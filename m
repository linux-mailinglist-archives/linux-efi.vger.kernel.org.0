Return-Path: <linux-efi+bounces-1638-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90E966BC2
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51E81F22A84
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FD17A906;
	Fri, 30 Aug 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r7ytJOSC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67B136337
	for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055159; cv=none; b=csOJ7uLFC0ZJVHCBjHmB4YDp6YJTBOJZMLJchXIyRTmC8/FOzHV2cuGK9SMkPLgxG9ygQCdKFqhNp4JFcaaWSc0ULtksFKT8pMfWVaq7cPxQzRL0IH2EUED0tp3G01WGrT6rrngOgAppPhw49v7+b5qFjL7cPPLnEh8vKnwr8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055159; c=relaxed/simple;
	bh=XiJIyfaxhsA2N4q9bumLRsRqgcH5ZumdF1S7+k+/ltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwhTbhxfvAIFCe2aYWeyT8vviVz6J+P/dliZcIHAXT0uo9F5Elem0LSox/ohjQz1AWwxVVoRNiJqcts5YRVE76SHCVbEbGswVruFNI+OF+Wm3l9ppGDk5xTX34FSgc2NiV8k40XAVQLuSwdHbDXdXl816gm0JS9l8F+nL5LGD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r7ytJOSC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567cdf32d8so12685811cf.1
        for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725055156; x=1725659956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRkh9HidVcc2cNXU9lTINQdEzHieK+w1xtxJeLCzVwQ=;
        b=r7ytJOSCAAgbb02W2ePghN4px6jfGFIUbRR3/O4nJSoR95rnWUGPBPg8Aq4t6T6tGq
         T8/BQwwwqgEfnndUoK3ZoMA2JkWbBdff04avtXEKFYsQabCztqYxIJ1U3TvYc81lKWSk
         Xbz+agbTNwhxarleB89bIATR+jPKjBWqe5g1AC36OVEAWTcCNGeHG5D0IOqntHkAUJL1
         5h9DE7mf1KeeQ1ZUV3jbfTxNdoZtKS8Rq5Y130sbKBA3623vg5OPeszgZecLu5cUV2zg
         a4sCKgw4SzzEX5BFOr9l27i/Mq1tJjVl4rt8SxPug/xMMotJ2zfhC3qBHzMvW71cvtIR
         QI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725055156; x=1725659956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRkh9HidVcc2cNXU9lTINQdEzHieK+w1xtxJeLCzVwQ=;
        b=Cg7fX2am6IEwqOixqOx2qmKqctnv1GMdMd3Mf2moZClwAlxi9IN7HUn2urpunx8WGW
         MYC4WMGcvRCKmbEOVRrH6nuJJBHVZJIzKlqeGiuJEeTQGED6qD0eiA8m4Cew0n6DlNIE
         2zoT7LE6kJWb1OqwwmizR2xvczpvcz7UT81UH8swTJ7QoCZhSO2zlHYYG3g2IpzGQ25d
         MvfvPy754TlMlVEOgFMZz7Pxn5goW6ArdtjAAolwyu1jqSFvGIaOg4Mrm2OnZd6iAfsL
         XsnuSIUGMvBMidovIwO/0mIEGiyw/3K8Me37vxMbeCnqyA1+H5LsImiTGvuqh5X0K9U7
         Ju0A==
X-Forwarded-Encrypted: i=1; AJvYcCUhqepUb3wakI+BdCP9bf+fcrGN46q9TAHU5VFRUwwqYTQ+CoNQ2jomXIWDr2d2jbS2sBoft3Nmhko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYw7Kmzua0X4ZxRTCMoA6uIu0gPGnq85Ypp7livx20Nkjfw43q
	m4zLKnlyyPEhXXr7Z3hYNkcxTUeRbc2C/gTDWptgEsciqNdeJzBtaN13UTA2jSI=
X-Google-Smtp-Source: AGHT+IHw+gab//FdYBaeNFjYy0XrUXWW7hGxnHn8v/0EYy92+u5qM5aJDZfXVK5l4MbWf9PF3KOo9A==
X-Received: by 2002:a05:622a:4c88:b0:456:7e7b:5339 with SMTP id d75a77b69052e-4569662ebc4mr12754851cf.37.1725055156218;
        Fri, 30 Aug 2024 14:59:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9d2e5sm17589981cf.25.2024.08.30.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:59:15 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:58:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, leitao@debian.org
Subject: Re: [PATCH] efi: reserve memory for tpm_log only if TPM final events
 table is valid
Message-ID: <ZtJAnkd3Rkh5Amfb@PC2K9PVX.TheFacebook.com>
References: <20240830212852.2794145-1-usamaarif642@gmail.com>
 <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
 <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
 <1a31390d-f452-4d53-84a9-b9fb2af71e4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a31390d-f452-4d53-84a9-b9fb2af71e4c@gmail.com>

On Fri, Aug 30, 2024 at 10:52:48PM +0100, Usama Arif wrote:
> 
> 
> On 30/08/2024 17:49, Usama Arif wrote:
> > 
> > 
> > On 30/08/2024 17:42, Gregory Price wrote:
> >> On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
> >>> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
> >>> negative). This can result in a large memblock reservation, resulting
> >>> in the kernel booting without sufficient memory. Move the memblock
> >>> reservation after log_tbl->version check, and check the value of
> >>> both tbl_size and memblock_reserve.
> >>>
> >>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>> ---
> >>>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
> >>>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> >>> index e8d69bd548f3..cfc6a065f441 100644
> >>> --- a/drivers/firmware/efi/tpm.c
> >>> +++ b/drivers/firmware/efi/tpm.c
> >>> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
> >>>  		return -ENOMEM;
> >>>  	}
> >>>  
> >>> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >>> -	memblock_reserve(efi.tpm_log, tbl_size);
> >>> -
> >>>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >>>  		pr_info("TPM Final Events table not present\n");
> >>>  		goto out;
> >>
> >> The final event table is not present in TCG 1_2 format, but the
> >> tpm log still needs to be mapped.  So this change is incorrect for
> >> v1_2.
> > 
> > hmm so we have 
> > 
> > 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > 		pr_info("TPM Final Events table not present\n");
> > 		goto out;
> > 	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > 		pr_warn(FW_BUG "TPM Final Events table invalid\n");
> > 		goto out;
> > 	}
> > 
> > If the format is TCG 1_2, then log_tbl is not used?
> > 
> 
> Ah its the case that log_tbl->size will be valid, even if its TCG 2.
> Got it, Thanks!

No, not necessarily.  The corruption issue is entirely separate from the
patches here. size can technically be 0xffffffff and treated as valid
because as far as I can see the spec does not define a maximum size.

the tl;dr here is that the above checks on tpm_final_log and log_tbl->version
gate mapping/operating on the final log - but do not have anything to
say about the event log.

There isn't really a good sanity check for whether or not to memblock_reserve
the log.  Possibly you add a LOG_FORMAT_MAX and check if version >= MAX,
but again that should be separate from the change that checks the return
value of the memblock_reserve call.

~Gregory

