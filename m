Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7469B769A4F
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGaPF1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGaPF0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 11:05:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D92D10DD;
        Mon, 31 Jul 2023 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0+kFd0PeLKGw7bCHBy4dn6TcM2mrgGMssJUohhcTcA0=; b=K8xAm8d84ZvAl6tQ0q8q3Xrfw9
        jzmMF7NG3Idujlq0AT6Rt2ArZwBhnJV3iNneG0vsF0uEVWgnt8TsZC/e+8R4zJ0c9AvFSCM2p5heh
        fLh1v88Fwx2Ff0v4gxerNhyojk3Go/acQuGmE1eaUWh3gOozCa//gT3/uR21xcZWKgHQmIVViaKsX
        E/ly9B1HPJqJGDjQU+4IRR1/EECWiTtSd+uSnrI1gKBfOuj3sXVF7twJdgj35Tfz94xSmgfUKDCAe
        4tczCaJd8HbQOHF9pA9cjFMkiZZS+hQuGyqkNdotAPSSLa1NsR6d0Lske76wByU19CCuzzpmaHUiB
        FMHQSTSw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQUSX-00GFIi-2e;
        Mon, 31 Jul 2023 15:05:21 +0000
Message-ID: <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
Date:   Mon, 31 Jul 2023 08:05:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731065041.1447-4-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/30/23 23:50, Masahisa Kojima wrote:
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..aa38089d1e4a 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -287,3 +287,18 @@ config UEFI_CPER_X86
>  	bool
>  	depends on UEFI_CPER && X86
>  	default y
> +
> +config TEE_STMM_EFI
> +	tristate "TEE based EFI runtime variable service driver"

	          TEE-based

> +	depends on EFI && OPTEE && !EFI_VARS_PSTORE
> +	help
> +	  Select this config option if TEE is compiled to include StandAloneMM
> +	  as a separate secure partition it has the ability to check and store

	                       partition. It has the ability

> +	  EFI variables on an RPMB or any other non-volatile medium used by
> +	  StandAloneMM.
> +
> +	  Enabling this will change the EFI runtime services from the firmware
> +	  provided functions to TEE calls.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tee_stmm_efi.

-- 
~Randy
