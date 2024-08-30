Return-Path: <linux-efi+bounces-1637-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B295C966B98
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A5CB21F62
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392F17556C;
	Fri, 30 Aug 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="W0/Mlgl2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AD16F910
	for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054923; cv=none; b=MTlFnTAHYJocPqAtM1wYM0VJxPlCZKPNNgir8WDCZ2zMfhUyw9G5Kas8qpF9kAMLIMPGlaAmkSjwwDIYZetwsCRo1fOZU/d/tve+A+oP96m3BwNQLn/8bS31+a3xKRRKbYd0A5PhaJ49uG/CndFts2IVrvD3xUBDvQ4atZDDn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054923; c=relaxed/simple;
	bh=3WNxOEpldK7+b/MMzUB3Q/Kuwjj588LOlLtTB/X17UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1awTuqHkKGzYVD0r5RhINoJjSRE96ouz7Ai+IQcAljaj3skC4wX3sWW0uSLvIANhhSpG/src1zPqoQcQ6vjirCInaBdNedRwvycFKdN0RuPTMZMeyxx00WnkGFf72mMAO/csCukTyyOcy+qI8JLHMabWDOevZhbMf2CExkKJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=W0/Mlgl2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c353f2f954so3785016d6.3
        for <linux-efi@vger.kernel.org>; Fri, 30 Aug 2024 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725054920; x=1725659720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zof+ib4mFVMfhYD6jriU8fcWJdFsEgp5TllKIk19lLc=;
        b=W0/Mlgl2mVC+RdiQDnPRCytlffPjGJ3ErGI5SJeOdEvn9F4cw1nWYStPZWntjPC063
         W+L1emTwMtzQnKOwbko/ncSJP/7nwoCuTNXNskHqVQ+bqV4V68AeMP1AMhtX/JcQly+5
         QuXB/RwbSzYRIAl0vOnP9Hoj5EECzM9WPrTLcYQ2nFLYNun5JQtKQtNKHsdOpSVSveN7
         s5RzGHQ7IGBzbMd7fxVtSl+odfKGkJ7gXQsZUBXSMskVyM7LUJVzGopTdxZ4adpVWuvr
         gIP1KJqqZp+DNqbHZrbwTAQEDc5F0+uAWzu0Z8oXiVmiHsZxTUznx24pTJqG5h9aBZi4
         v9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054920; x=1725659720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zof+ib4mFVMfhYD6jriU8fcWJdFsEgp5TllKIk19lLc=;
        b=ElVE83N4NHvBV2i388751622/3ycQEC1x9/CAl101hFLae3hi9RXYraguen6kicgOp
         xzSgCQiErAD8nwKYIXFSxj77fYXoBjfFH5jxSc7HjHkBFgfTRhssqEJoRTOqqDVeSfkC
         +w1IbgdlNt8Kl3djNSkp66v6hSACmhOuuyiAQCaJp3M5rZYwf+wriLD34+m5DiaKW8kV
         uNSRFqm09t/7HcVurd/AmF7OCVyhzodwCG/tosC76ZPw0z/YVepvYX8BFkJyHMKD/wE2
         m9RKizYmBXnG8At+dGeNW6ZTIMjAcHJ6H9On2ICYb8sTAOGyLca1bYwul5Gmtt2hdhrk
         8g1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrq9tWmQhyLaK1dzjrFpiq1d3eyzWPpdfjksSz0dCmaXXzgP/Oj1KgHWkD/GZMgRKxXQI/ieVaEUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3mRtuJbpc0rEWCJbxk2zG9LIePji9kbi/KNhLsX6cJsTVx4X
	G0yU2Pzjd9Y4KbRutPWF5dymS7JWC7spsGZvlZUfdXzJivYGGCypeDfbWcDLmJhtvBFEmjpnrLN
	G
X-Google-Smtp-Source: AGHT+IFt1CppFFGsBDFuVCJEpYrXE+m6smyUz2FBXWqXK4AV8s1bOV7RD1+IMxjF+Uojf69a30jOsw==
X-Received: by 2002:a05:6214:418b:b0:6b8:5afd:8f70 with SMTP id 6a1803df08f44-6c355f8a181mr6234026d6.49.1725054920509;
        Fri, 30 Aug 2024 14:55:20 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c34f84c64bsm6981096d6.60.2024.08.30.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:55:20 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:54:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, leitao@debian.org
Subject: Re: [PATCH] efi: reserve memory for tpm_log only if TPM final events
 table is valid
Message-ID: <ZtI_swMhk04eeYUm@PC2K9PVX.TheFacebook.com>
References: <20240830212852.2794145-1-usamaarif642@gmail.com>
 <ZtI82gt30kUhwkFY@PC2K9PVX.TheFacebook.com>
 <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f285bc-7540-4d70-8b6c-11675b68e9e4@gmail.com>

On Fri, Aug 30, 2024 at 10:49:46PM +0100, Usama Arif wrote:
> 
> 
> On 30/08/2024 17:42, Gregory Price wrote:
> > On Fri, Aug 30, 2024 at 10:28:52PM +0100, Usama Arif wrote:
> >> If efi.tpm_log is corrupted, log_tbl->size can be garbage (and
> >> negative). This can result in a large memblock reservation, resulting
> >> in the kernel booting without sufficient memory. Move the memblock
> >> reservation after log_tbl->version check, and check the value of
> >> both tbl_size and memblock_reserve.
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  drivers/firmware/efi/tpm.c | 16 +++++++++++++---
> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> >> index e8d69bd548f3..cfc6a065f441 100644
> >> --- a/drivers/firmware/efi/tpm.c
> >> +++ b/drivers/firmware/efi/tpm.c
> >> @@ -59,9 +59,6 @@ int __init efi_tpm_eventlog_init(void)
> >>  		return -ENOMEM;
> >>  	}
> >>  
> >> -	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >> -	memblock_reserve(efi.tpm_log, tbl_size);
> >> -
> >>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >>  		pr_info("TPM Final Events table not present\n");
> >>  		goto out;
> > 
> > The final event table is not present in TCG 1_2 format, but the
> > tpm log still needs to be mapped.  So this change is incorrect for
> > v1_2.
> 
> hmm so we have 
> 
> 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> 		pr_info("TPM Final Events table not present\n");
> 		goto out;
> 	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> 		pr_warn(FW_BUG "TPM Final Events table invalid\n");
> 		goto out;
> 	}
> 
> If the format is TCG 1_2, then log_tbl is not used?
> 
> 

if format is tcg 1_2 then log_tbl is used, which is reflected in libstub
drivers/firmware/efi/libstub/tpm.c

        efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
        int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;

        status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
        if (status == EFI_SUCCESS) {
                status = efi_call_proto(tpm2, get_event_log, version, &log_location,
                                        &log_last_entry, &truncated);

                if (status != EFI_SUCCESS || !log_location) {
                        version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
                        status = efi_call_proto(tpm2, get_event_log, version,
                                                &log_location, &log_last_entry,
                                                &truncated);
			^^^^^^^^ log still present in TCG 1_2 ^^^^^^^^^^^
                } else {
                        final_events_table =
                                get_efi_config_table(EFI_TCG2_FINAL_EVENTS_TABLE_GUID);
                }
        } else {

~Gregory

