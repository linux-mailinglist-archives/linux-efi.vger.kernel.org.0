Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17B17779F
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgCCNpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 08:45:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33842 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgCCNpZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 08:45:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so3425018qkd.1;
        Tue, 03 Mar 2020 05:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k3SVGsAkRULOndp1bH4Vy4WDCwesGWr3P2z5Nm2yK10=;
        b=sWbH2eXGNk7O1rQtiTzgMXTDZu43PmepDSxq/uNPdI7SoPgKCrQc597H3jFSvq2zv1
         he75Y3Zb2UfC0zVYPysm6n3V+dKaiHAnEWWMEgHkZTWindFlUzUwSNrgbYg8JwUUAuET
         K9VADaX7yvdP7LE2K8UTyxstGXHGw3Z7ZXBtsPfecPJGtAXaxrFtqlXDjnJJu84WC74g
         xVAZhKs+WisQ6K5jO6DzK1ETO9PjxW2uwIGBQk8cCYnKD0MZxpdfSG41qOjKPDD84cBd
         KkOo2PAR3ze0M7wNRVkVghDcTdire3inJI9/dDoxrSTL9HcS4rQo7xAjsJumQYgjF/Ka
         aRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k3SVGsAkRULOndp1bH4Vy4WDCwesGWr3P2z5Nm2yK10=;
        b=Bwkbv+MiRKDx2Wf92mwku23vPB6QvpIZozG8w9Utl9JyJyEQjzWxzNC+2Viuot10yr
         G5i0Es0qd4mn52YVJLKc4GeNVLKuBKhsYV6HM8RMHDlmqVUYa73Uod7L3ytBxbtfIPic
         sMXaeZtMKRGNrXxSk+dB7ar/Bk+ZqHko4MgNIdAfjCWPc9HD4xcxjK+fVWbuhMfl5tWu
         EwJbgsEffxir4g2HDyYgMvcYeP97VeSfYAv5ZKtkfX5At50VwhZpjPqlg9KvpQ76g1MK
         3eisOgb+3ZQ3cdiUybbVY5abjzdTuMhBH4Z9+pnzO42kvTQCeSeJ9+c3oy9pd3z3gmGO
         QSQQ==
X-Gm-Message-State: ANhLgQ1qkLdBHYpl9v2/a3H/3UBgzowPC7g3qcG1TFj88tSjiTvkToMF
        wl1zh6rlVmdDamwWKwLrc1iQuVrHnOU=
X-Google-Smtp-Source: ADFU+vtMcmjz2IkoUm+AEKIOmhmLZ+Zq/cFMxCPvZfbkApv9+ewkMMxJ3r0lr/5bDhlCrRFK+R2JMg==
X-Received: by 2002:ae9:ef4c:: with SMTP id d73mr3833332qkg.201.1583243123678;
        Tue, 03 Mar 2020 05:45:23 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o127sm12169290qke.92.2020.03.03.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:45:23 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 3 Mar 2020 08:45:21 -0500
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] efi/x86: Decompress at start of PE image load address
Message-ID: <20200303134521.GA3628638@rani.riverdale.lan>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200301230537.2247550-3-nivedita@alum.mit.edu>
 <dce7e026-ccb2-36f0-c892-83558dcc055f@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dce7e026-ccb2-36f0-c892-83558dcc055f@nextfour.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 03, 2020 at 06:28:20AM +0000, Mika Penttilä wrote:
> 
> 
> On 2.3.2020 1.05, Arvind Sankar wrote:
> > When booted via PE loader, define image_offset to hold the offset of
> > startup_32 from the start of the PE image, and use it as the start of
> > the decompression buffer.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/head_32.S      | 17 +++++++++++
> >  arch/x86/boot/compressed/head_64.S      | 38 +++++++++++++++++++++++--
> >  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++--
> >  3 files changed, 61 insertions(+), 6 deletions(-)
> 
> ...
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -19,6 +19,7 @@
> >  
> >  static efi_system_table_t *sys_table;
> >  extern const bool efi_is64;
> > +extern u32 image_offset;
> >  
> >  __pure efi_system_table_t *efi_system_table(void)
> >  {
> > @@ -364,6 +365,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >  	struct boot_params *boot_params;
> >  	struct setup_header *hdr;
> >  	efi_loaded_image_t *image;
> > +	void *image_base;
> >  	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
> >  	int options_size = 0;
> >  	efi_status_t status;
> > @@ -384,7 +386,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >  		efi_exit(handle, status);
> >  	}
> >  
> > -	hdr = &((struct boot_params *)efi_table_attr(image, image_base))->hdr;
> > +	image_base = efi_table_attr(image, image_base);
> > +	image_offset = (void *)startup_32 - image_base;
> 
> startup_32 == 0, so maybe something like
> 
> leaq	startup_32(%rip) - image_base
> 
> should be used ?
> 

That's what it already uses. All the files in this directory are
compiled to be position-independent, so it uses rip-relative addressing
on 64-bit and GOT-relative addressing on 32-bit.
