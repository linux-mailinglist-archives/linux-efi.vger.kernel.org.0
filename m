Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70E42DA95
	for <lists+linux-efi@lfdr.de>; Thu, 14 Oct 2021 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJNNie (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Oct 2021 09:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhJNNid (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Oct 2021 09:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B59610F9;
        Thu, 14 Oct 2021 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634218588;
        bh=yb0ExzouNkOeX4mfCayvzzwWXqG8VFL8qAlMemOcvC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTpbbbvxGO5lbAptCbEEw8h+Xf8OQcLwq/+Gv3SIOLh4CyoZvCN+Oe1lbRowNaRPS
         c3ZIku/+kJ2fGgGNuiHK/z1oOiEjY13jAyTUfdi9esYCNiTMLbZitSUtrfJnWtceCn
         kBR95wrcmQyr9+FWiFE069J2vt/eXubcPCwf/dpw=
Date:   Thu, 14 Oct 2021 15:36:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] efi: Reserve confidential computing secret area
Message-ID: <YWgyWeoreYusT9/s@kroah.com>
References: <20211014130848.592611-1-dovmurik@linux.ibm.com>
 <20211014130848.592611-3-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014130848.592611-3-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 14, 2021 at 01:08:47PM +0000, Dov Murik wrote:
> When efi-stub copies an EFI-provided confidential computing (coco)
> secret area, reserve that memory block for future use within the kernel.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  arch/x86/platform/efi/efi.c   |  1 +
>  drivers/firmware/efi/Makefile |  2 +-
>  drivers/firmware/efi/coco.c   | 41 +++++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/efi.c    |  4 ++++
>  include/linux/efi.h           |  3 +++
>  5 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/coco.c
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 147c30a81f15..35e082e5f603 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -93,6 +93,7 @@ static const unsigned long * const efi_tables[] = {
>  #ifdef CONFIG_LOAD_UEFI_KEYS
>  	&efi.mokvar_table,
>  #endif
> +	&efi.coco_secret,

Shouldn't this depend on CONFIG_EFI_SECRET?

Why build all of this code if that option is not enabled?

thanks,

greg k-h
