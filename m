Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB670D61A
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEWHzh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjEWHzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 03:55:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1221A7
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 00:54:41 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF32E41871
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684828448;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=I/o4Z7VpJhmk+AZ7sy/TPlfOxhtheQFD0kYTZC9nHGSmDafKRq190cbQSHLdSiDql
         wdjRIISQfQpIUW4nMX8l0s7ArauDG7h0OReiedHUhYzfwZNVMQsQeZlNkT0sX9rP5k
         nfRDKBo6KVRCiD4apH0o0QC0oKxNEexAXH+y4ceaTjFdKbBgdPk9knUDaTNDVYFKuQ
         ToYukhzP4RVZCHVwctPr+/R8/qWY2NYLonh/hxtz583J2lUybQwqrB30LW5WR7QJJn
         /tWMFUItyA6+/TTxDJSvKCaFHzUfn0Mnk9ZJM8O712E/pPU/xvIUCoT6l0DJOqhZ4C
         wdund7diVD3YA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-513ede5a2afso757934a12.1
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 00:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828448; x=1687420448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        b=QZkppClyURORybJKARvEdW5B4MXiTLnv82Q4lUmKfbMdr6ALDdazuv9YV6pplrfpKU
         +V48Fzlr9NYZF4eUm2Mcl4G46S5ayTsny73YgU5kvjj3cegnYIMTXb/fB9j8YwdJr68T
         ZHoy9bVIWWMq0/HBgNSARlVj55iGohQL0LvWE+u14gWj9e0P/cCvDV8nQNXJvMLlt7NH
         /gqwNcMXB77XiEu+zbRZyXLnuVge1lec0uAJNRdnfPsT734zXBKW0V4f7rAZH0DthkVY
         rc/CFVoLygojzVwTLEzkF7D3zk+saLf7I5FD5aas9ui2PFucbjeU3AYRevfEWK3fk742
         WeUA==
X-Gm-Message-State: AC+VfDxJp1S3PlJYNwFBqRmoi0N1nFo/xT5l129NVOGrZLk5nb7XY2C0
        bV9JTx7gMJN6UhlxPI6wJ5wUJSzWsg8DB1ySWRB2ELn/rFmksjRoBZRmllNGM0OjYyRI5ehY4vH
        4T7cWEmTU7i50I/6ZCSZZwM7nnfgkI/Q69ZlvhQ==
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512196edq.25.1684828448235;
        Tue, 23 May 2023 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ614T5qd3IOAYDd+hKdw79g7t/FzO5vlLLmvpMnQIMxNWV1Fe70N74Ytv61sx4QHR7rblD++g==
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512191edq.25.1684828447974;
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7d8c3000000b0050bfc4a9020sm3830973eds.38.2023.05.23.00.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Message-ID: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
Date:   Tue, 23 May 2023 09:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bungert <daniel.bungert@canonical.com>,
        Olivier Gayot <olivier.gayot@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH v2 0/1] block: fix conversion of GPT partition name to 7-bit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Davidlohr,

This is a no-change resubmission of a patch that I originally sent to
LKML without CC-ing the relevant subsystem maintainers:

https://lore.kernel.org/all/4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com/

I apologize for the oversight in my previous submission. 

--

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the first byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feels questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier
