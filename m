Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD86096A3
	for <lists+linux-efi@lfdr.de>; Sun, 23 Oct 2022 23:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJWV7a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Oct 2022 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJWV73 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 23 Oct 2022 17:59:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421FE8;
        Sun, 23 Oct 2022 14:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD31B80E05;
        Sun, 23 Oct 2022 21:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B7C433C1;
        Sun, 23 Oct 2022 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666562357;
        bh=QIXS1PuqKiNPYMIPPGfUEe7n27S1FRRrefLl9o0EJmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7HCQIJvdMFoW23Ct31ANSaovIhskNJuNKwCPlk2HlG+te4873uDpdZB5Q1LP7Ayj
         OQFLjhnRytrnJUgQVdaLcCzPxZ3kS1uQBT8CN7RdDcr3ccNeamp677VVYuAMZGAjQf
         oiMw4ss9nQS2UYeyojGCaw7kvTYffWyewtc2PJG/Z35ZkKMtyR36TJX/w+/rOSBV6Q
         RmPtgYjY6RzLBYFr38kAbdmrX/NlEOG7e9sKENJ2Kth0YE45inABGzs3o4BRX08BTm
         qO0oRKT1/SVx2Ief1qP0J/FZ9WDFqCvmtxtCcq+mOHbnh0qNt2LVnsPLWn8jabOIDt
         /sUT8EbiycWZQ==
Date:   Mon, 24 Oct 2022 00:59:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] efi/tpm: Pass correct address to memblock_reserve
Message-ID: <Y1W5LlI/fRo6XhU9@kernel.org>
References: <20221022152352.1033750-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022152352.1033750-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 22, 2022 at 08:23:52AM -0700, Jerry Snitselaar wrote:
> memblock_reserve() expects a physical address, but the address being
> passed for the TPM final events log is what was returned from
> early_memremap(). This results in something like the following:
> 
> [    0.000000] memblock_reserve: [0xffffffffff2c0000-0xffffffffff2c00e4] efi_tpm_eventlog_init+0x324/0x370
> 
> Pass the address from efi like what is done for the TPM events log.
> 
> Fixes: c46f3405692d ("tpm: Reserve the TPM final events table")
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Bartosz Szczepanek <bsz@semihalf.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/firmware/efi/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 8f665678e9e3..e8d69bd548f3 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -97,7 +97,7 @@ int __init efi_tpm_eventlog_init(void)
>  		goto out_calc;
>  	}
>  
> -	memblock_reserve((unsigned long)final_tbl,
> +	memblock_reserve(efi.tpm_final_log,
>  			 tbl_size + sizeof(*final_tbl));
>  	efi_tpm_final_log_size = tbl_size;
>  
> -- 
> 2.37.2
> 


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
