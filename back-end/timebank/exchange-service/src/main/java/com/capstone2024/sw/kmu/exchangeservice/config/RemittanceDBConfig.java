package com.capstone2024.sw.kmu.exchangeservice.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableJpaRepositories(
        basePackages = "com.capstone2024.sw.kmu.exchangeservice.repository.remittance",
        entityManagerFactoryRef = "transactionHistoryEntityManager",
        transactionManagerRef = "transactionHistoryTransactionManager"
)
public class RemittanceDBConfig {

    @Primary
    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.remittance")
    public DataSource transactionHistoryDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Primary
    @Bean
    public LocalContainerEntityManagerFactoryBean transactionHistoryEntityManager(
            EntityManagerFactoryBuilder builder
    ) {
        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "none");

        return builder
                .dataSource(transactionHistoryDataSource())
                .packages("com.capstone2024.sw.kmu.exchangeservice.domain.remittance")
                .persistenceUnit("remittance")
                .properties(properties)
                .build();
    }

    @Primary
    @Bean
    public PlatformTransactionManager transactionHistoryTransactionManager(
            @Qualifier("transactionHistoryEntityManager") EntityManagerFactory entityManagerFactory) {
        return new JpaTransactionManager(entityManagerFactory);
    }
}
