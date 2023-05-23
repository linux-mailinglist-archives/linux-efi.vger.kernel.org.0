Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35170D64F
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 09:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjEWH5t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjEWH4n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 03:56:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6818610F0
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 00:55:55 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 834CB41872
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684828500;
        bh=qtqNtwIvHhIeqkZGLNoRzzzucpyk3+iXCeDnt3ORDmY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VrkZ4bEeF39LPrEFDUT+X00Shpf49MeKvy9eDTqAkqTvbGtKbgoRor28Ya4JvdK95
         zhHnkv/kFMiPLv6ghYRombKvRJSoEsJArnFNvqq0sf6zpWq/yWcWEdBxnvu0Dpqgfu
         5XEz5um9+b+cHM2I4ZlH8YzldC4kjhtBMsloYMkGPcnf40WCEdVmzdSxydX2v+opej
         ytwu3AcuedT0Uxs0ioD9NxZC/2DlTOi+HnK4aLwu7qlDOZfKYK0r+ulXlq6VhyCkNo
         +SpvIW05cYMZs0QS8/SFhXr4cg7rtY9kEqUXjl8gQj38KVomVLtWpgAJg8h+TcQ1vS
         njjAWwSyU99Lg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a348facbbso902802866b.1
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828500; x=1687420500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtqNtwIvHhIeqkZGLNoRzzzucpyk3+iXCeDnt3ORDmY=;
        b=hJzUzWCqgI+LYtGLwgo/3JWv+vN5//4dhaX1JAf0PnC+3QPgbxG0Byv2KN9UMIjnTV
         CGBE1fxjkTJtmazDs7Y0YsTwy92wv0J8xhoZwfXcGB/cghppfZqXGgKAPpYUKkREATpj
         eCwzheHSrXGplytqRD6T+QQWG8VCNbLdtKRTZzw7zZty8O8VgXca97oN0uS62JcTJiz0
         N/2H6LQYZJleU7kBMALUXBz7o/3mP/XN8ccavft7ZPBU+JjSdlLTMGm0iNvWsp3xhZHZ
         bL5cnwTCp6Hb8kaEH2sNP9Yw7b62hsEdRegSB3JBDdEZBvIzQAZxDgxyLKnQx/NHW8k5
         0n2A==
X-Gm-Message-State: AC+VfDwjEjIEeYkvwTjFIE1LACu8FkPmra4lYz2RSo3NnJgxM+ublxML
        s0s34AjLokTlCmYdj4ZB0vxvoekf5QY0MRfJSzSS7zEqatKT4dB4JchNShhsKI3iINks8H6LPSj
        f5X6FKvXAdP7d28rDpQDWgwxdPRbmh3sjDNU+0A==
X-Received: by 2002:a17:906:9b84:b0:968:2b4a:aba3 with SMTP id dd4-20020a1709069b8400b009682b4aaba3mr16313193ejc.5.1684828500277;
        Tue, 23 May 2023 00:55:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fSgDV8mfBBEU3q/qNohso/VI8Hks7zkK0UCj0MoQ5SQcWGXBW8Ig3nAJC1XyBZ6Nwic+v7A==
X-Received: by 2002:a17:906:9b84:b0:968:2b4a:aba3 with SMTP id dd4-20020a1709069b8400b009682b4aaba3mr16313166ejc.5.1684828499996;
        Tue, 23 May 2023 00:54:59 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090657ca00b00960005e09a3sm4106862ejr.61.2023.05.23.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:54:59 -0700 (PDT)
Message-ID: <e16bcbb5-c2fe-f168-410b-824358f0a48e@canonical.com>
Date:   Tue, 23 May 2023 09:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v2 1/1] block: fix conversion of GPT partition name to 7-bit
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bungert <daniel.bungert@canonical.com>,
        Olivier Gayot <olivier.gayot@canonical.com>
References: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

Fixed by using a mask of 7 bits instead of 8 bits before calling
isprint.

Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
---
 V1 -> V2: No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';

