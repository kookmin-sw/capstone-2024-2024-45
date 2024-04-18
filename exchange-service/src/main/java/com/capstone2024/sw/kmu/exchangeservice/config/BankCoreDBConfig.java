package com.capstone2024.sw.kmu.exchangeservice.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.sql.DataSource;

@Configuration
@EnableJpaRepositories(
        basePackages = "com.capstone2024.sw.kmu.exchangeservice.repository.bankcore",
        entityManagerFactoryRef = "bankCoreEntityManager",
        transactionManagerRef = "bankCoreTransactionManager"
)
public class BankCoreDBConfig {

    @Bean
    @ConfigurationProperties(prefix = "spring.datasource-bankcore")
    public DataSource bankCoreDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean bankCoreEntityManager() {
        LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactoryBean.setDataSource(bankCoreDataSource());
        entityManagerFactoryBean.setPackagesToScan("com.capstone2024.sw.kmu.exchangeservice.domain.bankcore");
        entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        return entityManagerFactoryBean;
    }

    @Bean
    public JpaTransactionManager bankCoreTransactionManager() {
        return new JpaTransactionManager(bankCoreEntityManager().getObject());
    }
}
