package com.capstone2024.sw.kmu.exchangeservice.config;

import jakarta.persistence.EntityManagerFactory;
import   org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableJpaRepositories(
        basePackages = "com.capstone2024.sw.kmu.exchangeservice.repository.bankcore",
        entityManagerFactoryRef = "bankCoreEntityManager",
        transactionManagerRef = "bankCoreTransactionManager"
)
public class BankCoreDBConfig {

    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.bankcore")
    public DataSource bankCoreDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean bankCoreEntityManager(
            EntityManagerFactoryBuilder builder
    ) {
        Map<String, Object> properties = new HashMap<>();
        properties.put("hibernate.hbm2ddl.auto", "update");

        return builder
                .dataSource(bankCoreDataSource())
                .packages("com.capstone2024.sw.kmu.exchangeservice.domain.bankcore")
                .persistenceUnit("bankcore")
                .properties(properties)
                .build();
    }

    @Bean
    public PlatformTransactionManager bankCoreTransactionManager(
            @Qualifier("bankCoreEntityManager") EntityManagerFactory entityManagerFactory) {
        return new JpaTransactionManager(entityManagerFactory);
    }
}
