Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B1552CBD6
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 08:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiESGRL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 02:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiESGRK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 02:17:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427313DFE
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 23:17:08 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 301DF3F1D9
        for <linux-efi@vger.kernel.org>; Thu, 19 May 2022 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652941027;
        bh=iLPp7ziXAsX6FDkJEBbt+kvfz2sQEIiFRkhbxw0UqIU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qF1gFHdqzdy/V3qvbkUPU9sP6wnw1auP8Zd64V5RSx80uxyuGGqnbO5BL3gqhn2Yn
         sk8cckn2BXDJCleOtGHqXgIpcKG9LT0X5lDXxJVi88eq9rA9QjxVFQGWX0Qv0A35JI
         Lp7x2UEuyaYu0FOvzXg3sQdJOWIEgmjiCF5fa7Ft74amNJNZasz6io6iggKm6cwoS6
         QOm4aUxuoNuzIIjXSdHLRwqLyKm29bKJ8a7+OMk78yOHnjw68IygQppxV4A8WyMdkk
         BWD9ajQHWwZUNKhDX8ElmS5ufo1DdcacNZ4KcRkGs9loYgZNsfzLieVTNFOETwd12K
         XjzJ/lqyYgh9g==
Received: by mail-ej1-f70.google.com with SMTP id r16-20020a170906c29000b006fe56366024so1972532ejz.20
        for <linux-efi@vger.kernel.org>; Wed, 18 May 2022 23:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iLPp7ziXAsX6FDkJEBbt+kvfz2sQEIiFRkhbxw0UqIU=;
        b=r203e4lcQbME49s5Tj5bPlDPHYsZNSJZO5Wh5FrxyD0EtKiFQ2NRew7mCL2dXDHbNq
         jfkw+eo3K3TsRfGSSccW3rd4zGjvzUsT97lvIhLf3NB/MMKh1jps5OZ4anw5qQzq0NfK
         O3D+FiMeCCmxGUaZlFUy1mjPlaZgmj3eEJlc5iG+VP3P4WgGs6QsAom4Y977NDAOnD8b
         ja5Mhm/97+uF6KV4No/u66+5pfZAP44xPCsBpv1Zi0xxLctWtycbp0OhJmXLiNtFSRgv
         0GWVgJaMvKK9PgOAKQ0PyIRHXbRMijUYLObYP+hrqn/5F9iKcIFBgaKR/ckjx2BK2foI
         VWLg==
X-Gm-Message-State: AOAM532RyHSzHUyoWW/SM1YDWfB0MTFuyoCGVpuhCyVQ5rmvVMJ5Idl+
        Wh+k6Gyj3UhdjXUvFPIt8prnyL8fjvBUyN9T0xmgBfUY6aj1GH3vdcjuw/Z7OfmbFYTyr3Ov09n
        ggFLgyDFiEF52JX+9SSMpnlmI5CRXOvik933icg==
X-Received: by 2002:aa7:dbd0:0:b0:427:4e6e:d779 with SMTP id v16-20020aa7dbd0000000b004274e6ed779mr3579777edt.27.1652941026679;
        Wed, 18 May 2022 23:17:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGLpdzfJ/wusUFeW8GTYv5edPH5/Q2voQaQff7V/kHhSWeuDJuESlX5CSuWHn9q8wcPMkkPQ==
X-Received: by 2002:aa7:dbd0:0:b0:427:4e6e:d779 with SMTP id v16-20020aa7dbd0000000b004274e6ed779mr3579757edt.27.1652941026377;
        Wed, 18 May 2022 23:17:06 -0700 (PDT)
Received: from [172.25.0.188] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id cq3-20020a056402220300b0042617ba63c2sm2382660edb.76.2022.05.18.23.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 23:17:05 -0700 (PDT)
Message-ID: <04ed20b1-e312-dfc2-c314-02750c076681@canonical.com>
Date:   Thu, 19 May 2022 08:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
References: <20220518095646.47548-1-sunilvl@ventanamicro.com>
 <20220518095646.47548-2-sunilvl@ventanamicro.com>
 <CAMj1kXF2N+0zRCNg0Aq9Y8Y35FUaQ1V+swzY__y86sayKW7PPA@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXF2N+0zRCNg0Aq9Y8Y35FUaQ1V+swzY__y86sayKW7PPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 5/18/22 23:03, Ard Biesheuvel wrote:
> On Wed, 18 May 2022 at 11:57, Sunil V L <sunilvl@ventanamicro.com> wrote:
>>
>> This patch adds the support for getting the boot hart ID in
>> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
>> is preferred method over existing DT based solution since it
>> works irrespective of DT or ACPI.
>>
>> The specification of the protocol is hosted at:
>> https://github.com/riscv-non-isa/riscv-uefi
>>
>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
>>   drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
>>   include/linux/efi.h                       |  1 +
>>   3 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index edb77b0621ea..aced62a0907e 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
>>          } mixed_mode;
>>   };
>>
>> +struct riscv_efi_boot_protocol {
>> +       u64 revision;
>> +
>> +       efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
>> +                                                 size_t *boot_hartid);
> 
> size_t is not a EFI type, and your spec uses UINTN here, which is
> equivalent to 'unsigned long'. However, jump_kernel_func() takes a
> unsigned int for the hartid. Please clean this up.

unsigned long and size_t have the same number of bits. This seems to be 
a question of taste where we should follow the maintainer.

jump_kernel_func() assuming boot hart ID to be an unsigned int is not in 
line with the RISC-V ISA which allows to use all xlen bits.

> 
> 
>> +};
>> +
>>   typedef union efi_load_file_protocol efi_load_file_protocol_t;
>>   typedef union efi_load_file_protocol efi_load_file2_protocol_t;
>>
>> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
>> index 9c460843442f..012504f6f9a4 100644
>> --- a/drivers/firmware/efi/libstub/riscv-stub.c
>> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
>> @@ -23,7 +23,7 @@
>>
>>   typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
>>
>> -static u32 hartid;
>> +static size_t hartid;
>>
> 
> and here
> 
>>   static int get_boot_hartid_from_fdt(void)
>>   {
>> @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
>>          return 0;
>>   }
>>
>> +static efi_status_t get_boot_hartid_from_efi(void)
>> +{
>> +       efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
>> +       efi_status_t status;
>> +       struct riscv_efi_boot_protocol *boot_protocol;
>> +
>> +       status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
>> +                            (void **)&boot_protocol);
>> +       if (status == EFI_SUCCESS) {
>> +               status = efi_call_proto(boot_protocol,
>> +                                       get_boot_hartid, &hartid);

A lot of the kernel code seems to be unfit to handle hart IDs exceeding 
INT_MAX (e.g. sbi_cpu_is_stopped()). Until this is fixed we have to 
treat hartid > INT_MAX as an error.

Best regards

Heinrich

>> +       }
>> +       return status;
>> +}
>> +
>>   efi_status_t check_platform_features(void)
>>   {
>>          int ret;
>> +       efi_status_t status;
>>
>> -       ret = get_boot_hartid_from_fdt();
>> -       if (ret) {
>> -               efi_err("/chosen/boot-hartid missing or invalid!\n");
>> -               return EFI_UNSUPPORTED;
>> +       status = get_boot_hartid_from_efi();
>> +       if (status != EFI_SUCCESS) {
>> +               ret = get_boot_hartid_from_fdt();
>> +               if (ret) {
>> +                       efi_err("Failed to get boot hartid!\n");
>> +                       return EFI_UNSUPPORTED;
>> +               }
>>          }
>>          return EFI_SUCCESS;
>>   }
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index ccd4d3f91c98..9822c730207c 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
>>   #define EFI_CONSOLE_OUT_DEVICE_GUID            EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>>   #define APPLE_PROPERTIES_PROTOCOL_GUID         EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
>>   #define EFI_TCG2_PROTOCOL_GUID                 EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
>> +#define RISCV_EFI_BOOT_PROTOCOL_GUID           EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>>   #define EFI_LOAD_FILE_PROTOCOL_GUID            EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>>   #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>>   #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
>> --
>> 2.25.1
>>
