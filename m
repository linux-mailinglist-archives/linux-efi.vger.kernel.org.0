Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6560B1665E4
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 19:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBTSLi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 13:11:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46630 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgBTSLi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 13:11:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so4411507qkh.13
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpM7W1qNT+lsYW1+7ZPasuB4njTAyUnv71h5WutgTpE=;
        b=su92ESrkJEUJEERQtQsZTx+E2HFbsFNxl+5Atuq8ZOHbf+lbEvs0UX9BNXCFjxIrfg
         VaVHdcfgEppV8TF8zxc2hv2iFqI2ozZPjRIHq1BGo1GoB3FxJHxDMR131+9+iA9PKp8u
         d3Mlk7hJYYjbe5Pa4/jCx9rcy9/u0Y4YzSo9HhiYEZLbzBKIQU+mX+q0xn99xcJHNVA0
         XhO4kjWOi2Dp4Y0wMCzNng5Gf5mr0t0Ne7ugt9oVwcv3SHLxSAUOY7skxsmtE4qHmwg7
         7yosRPPla2XUJUm/k9F1oIUICuBf70R3DsZYcQq4UvThnjwwDUdxRE0REUzdmHODIS24
         sA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpM7W1qNT+lsYW1+7ZPasuB4njTAyUnv71h5WutgTpE=;
        b=Ydh9Hhcc3j8szJkbfdI+XdkPjNLlSWuZn4fIviPHpPagIKwqTT1k1YjfWEwGQfgbPx
         BFZWTJgJhJNg0RAOlZ4wk2ViPfu7/uTds4DN+T6Fnv5yoo1/2Eg2cG2ZNtjo6+8lYGaf
         CGIE9ulm5SMsGwkiQDgBzDevpJhntaX+5SMuZHb6BqSUR9N+KpkWCyW3z1IFOUj2le1V
         0CkHYfx5xK1oNwA9djVib8++9yomof34+BpTCjv1rULfxg8Gszxn0q6uwtmdgQZp/+sp
         7cU/W1jsF2z+NcslABGidQ1YYx4oAU07vnsn9Gpmxd0HiQgumQaIi321UyD3GHAnlM5D
         oerA==
X-Gm-Message-State: APjAAAVslbwfQGsZhj20wq5M48QMWq/mcA3ihGe7sv8lSxvdEHwHVyVQ
        y8z/k8eUBU72lMWx3GqgLjA=
X-Google-Smtp-Source: APXvYqyEsmSHYmQ2T3WRMWmm4xEns2vWQK9PT1axzVKSPyrbtA6Cmd2KGAym08VXDK8IYdQy9dwl7g==
X-Received: by 2002:ae9:e114:: with SMTP id g20mr29379020qkm.458.1582222297246;
        Thu, 20 Feb 2020 10:11:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g2sm178440qkb.27.2020.02.20.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 10:11:36 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 13:11:35 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220181134.GA2443997@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
 <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
 <20200220180454.GA2436919@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220180454.GA2436919@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 01:04:54PM -0500, Arvind Sankar wrote:
> On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> > Another thing I wondered was whether we really need the .reloc
> > section. We don't have one on ARM, and it works fine with the existing
> > EDK2 loader.
> > Peter: any idea whether the issue with .reloc you pointed out to me
> > the other day still exists in EDK2 today?
> 
> commit 743628e868c5 ("x86, efi stub: Add .reloc section back into
> image") says that
> 	Some UEFI firmware will not load a .efi with a .reloc section
> 	with a size of 0.
> 
> Is that the issue you're refering to? It is a bit odd, since we actually
> leave base relocation table at a size of zero with an RVA of zero, so it
> shouldn't even look at the .reloc section according to the spec. At
> least current EKD2 code doesn't seem to -- I think it would even work if
> you specify fewer tables than 6 so that the base relocation table is
> missing altogether.

Another couple of odd things are that the PE header is supposed to be
8-byte aligned which we don't do, and NumberOfSymbols is set to 1 --
should be 0, no?
