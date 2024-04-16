package com.capstone2024.sw.kmu.exchangeservice.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;

@Configuration
@EnableJpaRepositories(
        basePackages = "com.capstone2024.sw.kmu.exchangeservice",
        entityManagerFactoryRef = "transactionHistoryEntityManager",
        transactionManagerRef = "transactionHistoryTransactionManager"
)
public class RemittanceDBConfig {

    @Primary
    @Bean
    @ConfigurationProperties(prefix = "spring.datasource-remittance")
    public DataSource transactionHistoryDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Primary
    @Bean
    public LocalContainerEntityManagerFactoryBean transactionHistoryEntityManager() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(transactionHistoryDataSource());
        entityManagerFactoryBean.setPackagesToScan("com.capstone2024.sw.kmu.exchangeservice");
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        return entityManagerFactoryBean;
    }

    @Primary
    @Bean
    public JpaTransactionManager transactionHistoryTransactionManager() {
        return new JpaTransactionManager(transactionHistoryEntityManager().getObject());
    }
}
