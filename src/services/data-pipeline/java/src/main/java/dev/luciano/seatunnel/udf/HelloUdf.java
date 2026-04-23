package dev.luciano.seatunnel.udf;

import com.google.auto.service.AutoService;
import org.apache.seatunnel.api.table.type.BasicType;
import org.apache.seatunnel.api.table.type.SeaTunnelDataType;
import org.apache.seatunnel.transform.sql.zeta.ZetaUDF;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@AutoService(ZetaUDF.class)
public class HelloUdf implements ZetaUDF {

    private static final Logger LOG = LoggerFactory.getLogger(HelloUdf.class);

    @Override
    public String functionName() {
        return "HELLO";
    }

    @Override
    public SeaTunnelDataType<?> resultType(List<SeaTunnelDataType<?>> argsType) {
        return LocalTimeType.LOCAL_DATE_TIME_TYPE;
    }

    @Override
    public Object evaluate(List<Object> args) {

       LOG.info("Evaluating HelloUdf with arguments: {}", args); 

        String input = (String) args.get(0);    
        return "Hello, " + input + "!";
    }
}