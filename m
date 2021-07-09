Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCDF3C27AC
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jul 2021 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhGIQlc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jul 2021 12:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhGIQlc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Jul 2021 12:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48B74613B4;
        Fri,  9 Jul 2021 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625848728;
        bh=a1GISkv/+pWga0fuN5hJ5ZjRXhhLHwqNa2THjWIVVyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iuk9WFJR/gnoHhhLixZZL1Qt8UMWvT704PCJFZaW9jX0oREYzGgmYNk2oAyCs1iZq
         w1JFvLRVPZxmEpB+ttMRLb/1zUOhvk0rx3fzG6MIDJOF24q7KEt5D50OZs6Z2k6v/B
         eMWGKaVcWEYVmQ3ZdHL3yxxu1JMBjbtBq8Pc2rpakCD6hOQrmD5IWR3f9FjuUVXLg1
         Wa9ZoYZT9cARhFYknnYfIeLNBhSDe7yl4DlfeafStJLHpP00T9FN9FGs/kzBtdJhuc
         ABel8KIJCbbBKJ5GUbLO9Ewacy0QO1ErxyXy5SYz7puEd5ZSaFfhaKcqobj9duT/9a
         zYobmtu/RH1LA==
Date:   Fri, 9 Jul 2021 19:38:46 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?TG/Dr2M=?= Yhuel <loic.yhuel@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/tpm: Differentiate missing and invalid final event
 log table.
Message-ID: <20210709163846.3e753oectgbt7wh7@kernel.org>
References: <20210708094654.4157-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708094654.4157-1-msuchanek@suse.de>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 08, 2021 at 11:46:54AM +0200, Michal Suchanek wrote:
> Missing TPM final event log table is not a firmware bug.
> 
> Clearly if providing event log in the old format makes the final event
> log invalid it should not be provided at least in that case.
> 
> Fixes: b4f1874c6216 ("tpm: check event log version before reading final events")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/firmware/efi/tpm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index c1955d320fec..8f665678e9e3 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -62,9 +62,11 @@ int __init efi_tpm_eventlog_init(void)
>  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
>  	memblock_reserve(efi.tpm_log, tbl_size);
>  
> -	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
> -	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> -		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
> +	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> +		pr_info("TPM Final Events table not present\n");
> +		goto out;
> +	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +		pr_warn(FW_BUG "TPM Final Events table invalid\n");
>  		goto out;
>  	}
>  
> -- 
> 2.26.2
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
