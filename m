Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35A15B5E2
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 01:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgBMAew (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 19:34:52 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34118 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBMAew (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Feb 2020 19:34:52 -0500
Received: by mail-qt1-f170.google.com with SMTP id h12so3157040qtu.1
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 16:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbzWTmlI92fxPxuN1voD79dF6p9bHCVqQjh6L8nnqdc=;
        b=q0HxzbFatHONVpgeoeXmREzJsh1wDJWpSMwyyLo4YlmAUtsm3YeVL1J0yp3sWymt4Z
         r6IXjHiVCzYYoPeUbp9SIgqXFAy9+Kle2PV8PSbMaaIcXAWpxyA4D4TqUHb288Vo6460
         VQJxYtoyDjq5Q4tMk/KdElah0gAY9tTlZk1hck8B+ppa1bQ6aLisUZ4F21FxSAltEs9R
         0sknBNDMD+QQg1ILMcuJBI9vsfblhjkEyyiOA90I6th9HB0t6aTPA1RaIbihwVgI8iGO
         0fWbNn/zlKe95ffYWoibYjora8A2htJDuNzz7yQZGRMovcqw/bYoiIQCMMMQbuwqZL04
         FkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbzWTmlI92fxPxuN1voD79dF6p9bHCVqQjh6L8nnqdc=;
        b=psd3pVgslWaqpWph5EHj/WGt4XOrcqI+OAthasK+8mL4erIjr6Z6HBgW2sjEw1H2QI
         sBMnQswFTWtFIjNdBuG3bVlNCPufr30145zKi1QMYRTNX33x/V5xa1kSTs/Qa4NcnT6u
         kV6m0Kd2RiZV4RXW/fuZ5/qdWf3P3iMDJJweEZnO2pFhCguvHO9QiklnZxBBhp2LKAQY
         dcphZ7wgZySObUyM7Cpg8QTSMGsmJkDVpGXcWkbHPKwnuCl7fdiIxCv2pmNu63Ikzdx6
         E5TWiC9DOrjPzQD/ULt4ojJbbwswnjx00eshVswTVFY5mN9CcNAknkCdxTSz3ole1gvX
         4VRQ==
X-Gm-Message-State: APjAAAXT2Riyv1b83VuWjBsg95OFtnutxo3AwyRcc+kV7zp8VCSegjLp
        cx0BuJg98Um+nf7VPT+p0Qc=
X-Google-Smtp-Source: APXvYqzapykhVwBlHKF13f0hBuBc1hFsX5FevEXiX2OdXnmMiZJD4hXUPgbA5DRXcYM3JBKrWWKSwg==
X-Received: by 2002:ac8:530c:: with SMTP id t12mr9040627qtn.83.1581554091416;
        Wed, 12 Feb 2020 16:34:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t29sm357874qkm.27.2020.02.12.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:34:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 12 Feb 2020 19:34:49 -0500
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
Message-ID: <20200213003449.GA1190065@rani.riverdale.lan>
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
 <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
 <20200212215717.GA958135@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212215717.GA958135@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 12, 2020 at 04:57:19PM -0500, Arvind Sankar wrote:
> However, I'm also getting confused about how mixed-mode works at all if
> we have more than 4Gb RAM, which it seems we want to support as we take
> pains to allocate a stack below 4Gb for the thunk. But in this case, the
> kernel text and stack could be above 4Gb physically, so rather than
> using a 1:1 map we'd need to find some space in the low 4Gb of virtual
> addresses to map those, but I don't see where we do this? Also, that
> dynamically allocated variable_name could be above 4G as well.

Verified in QEMU that mixed mode crashes if physical RAM can extend
above 4G. Are there any such real devices in existence? Should we check
that and disable runtime services if so?
