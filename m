Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBC58D593
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiHIImo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiHIImm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:42:42 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E3220DC
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:42:39 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 144063F467
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660034558;
        bh=rMu3QBc2zrhp5woSh3VBBx+UaxeyaUxzWhvH3YRNXDE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=B5Z0crqCxn+9S59s+yb9/BppSxeX//qPrFZVbkndUSXzISEx1GkKOqRrPKohhsRnC
         tIADSeeqgYqx8dU+8WZbvonXE80+XKZoe6jWQow+ZTLUa5SP7sgbU298PXc+J+6VXM
         llpzmYTQdP+p6GVChdle8dXIztPLwN2B74MOJYCbUBZidQv/SALtkplMg0DUlD4VzW
         A9oKJ0vnANSoDS6fjS3ry8l/aKl5hT34VtEKd2cGK+iE46QZDn2jzKKL4TVTu8V8IO
         GP8Ven9K/WXYJ+9vFkQ1ile02cUzyLKMT9qOCbp5qs8s81Z4gD0KqoznwVFbX6i5LV
         8Pd2dTzQguqAQ==
Received: by mail-ed1-f70.google.com with SMTP id m22-20020a056402431600b0043d6a88130aso6840917edc.18
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 01:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rMu3QBc2zrhp5woSh3VBBx+UaxeyaUxzWhvH3YRNXDE=;
        b=5F3+uzvzbOd/fTU9yMkPJEmBfec8rnLEEFGIEw21np/lUaldlu0uYHJwaCabLcib0w
         MZ5LFwQQXjtmlqAj4QoRkBJdYWjXDmeBYkqu1tHgfc2RuS+S+ZQiP7+2KPnSP0WFG9ia
         y6GLRrTQeZC2kLAwc6hA298izyyJysKUv8D3L9pO2APTINTk1juACDysYbT0O0MKdut6
         jW5QtdrCx56eBgdzkJc6xvv4uie68BuwimLtkZIw1p6mj86j2VTqnwyXesQHkP89+48r
         XEKOhLGfAwcBeAr+9eaa5TNpfHp7qZb6GNsKUEAqPsSv45EoOG9FIYCGvPmrgTSOCZTz
         /7iQ==
X-Gm-Message-State: ACgBeo2H0gvXSEZqqShtmeaTsgh8JsQfhLvaJsXW5hy1Flx2qiDpLU6o
        MIqoyy4b0CJ+Xbwl5MKV/DQI/TiBF1WXLzFIZ8TuRtQDXmbfvBqLNTCRinOA9EHeiTXETcGSeGO
        jPfYQaLVi5fbzZCL3MfCUwoPwKl0/DLiqqbbGVA==
X-Received: by 2002:aa7:cf18:0:b0:43d:34e:11b9 with SMTP id a24-20020aa7cf18000000b0043d034e11b9mr21127001edy.145.1660034557645;
        Tue, 09 Aug 2022 01:42:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57TYulbw78SFuNZwHg1OzdggdMnuEQUgPUomyOBzpksEBVMJJKRK1/TYAIr3mTWYSl7vlZnA==
X-Received: by 2002:aa7:cf18:0:b0:43d:34e:11b9 with SMTP id a24-20020aa7cf18000000b0043d034e11b9mr21126987edy.145.1660034557453;
        Tue, 09 Aug 2022 01:42:37 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402005500b0043ceb444515sm5700364edu.5.2022.08.09.01.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:42:37 -0700 (PDT)
Message-ID: <73e60ddb-85ae-3b98-aa26-4bf864a02734@canonical.com>
Date:   Tue, 9 Aug 2022 10:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 1/6] efi: stub: add some missing boot service
 prototypes
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        linux-efi@vger.kernel.org
References: <20220809080944.1119654-1-ardb@kernel.org>
 <20220809080944.1119654-2-ardb@kernel.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220809080944.1119654-2-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/9/22 10:09, Ard Biesheuvel wrote:
> Define the correct prototypes for the load_image/start_image and
> install_multiple_protocol_interfaces boot service pointers so we can
> call them from the EFI zboot code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   drivers/firmware/efi/libstub/efistub.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index ab9e990447d3..33215d7bd276 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -254,8 +254,12 @@ union efi_boot_services {
>   							    efi_handle_t *);
>   		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
>   								     void *);
> -		void *load_image;
> -		void *start_image;
> +		efi_status_t (__efiapi *load_image)(bool, efi_handle_t,
> +						    efi_device_path_protocol_t *,
> +						    void *, unsigned long,
> +						    efi_handle_t *);
> +		efi_status_t (__efiapi *start_image)(efi_handle_t, unsigned long *,
> +						     efi_char16_t **);
>   		efi_status_t __noreturn (__efiapi *exit)(efi_handle_t,
>   							 efi_status_t,
>   							 unsigned long,
> @@ -277,8 +281,8 @@ union efi_boot_services {
>   		void *locate_handle_buffer;
>   		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
>   							 void **);
> -		void *install_multiple_protocol_interfaces;
> -		void *uninstall_multiple_protocol_interfaces;
> +		efi_status_t (__efiapi *install_multiple_protocol_interfaces)(efi_handle_t *, ...);
> +		efi_status_t (__efiapi *uninstall_multiple_protocol_interfaces)(efi_handle_t, ...);
>   		void *calculate_crc32;
>   		void *copy_mem;
>   		void *set_mem;

