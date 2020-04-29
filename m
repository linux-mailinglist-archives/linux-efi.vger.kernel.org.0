Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F093E1BE9F3
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgD2Vd4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2Vdz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:33:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EF9C03C1AE;
        Wed, 29 Apr 2020 14:33:54 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w18so1976097qvs.3;
        Wed, 29 Apr 2020 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wY8xzcZXiZde7TJl9Xy1dRAvvuucPAiZm9ruZU0s2jU=;
        b=se6XABJRF04/CCxY7HXjp6MyXJAF9PPqHIYHcAA1nThgrpn9/7axKm+tFMc3vDTjzU
         mNZaU6XAy54XUj7LIjr8PUQ1/1k2W6ZZ5gbxHn8S+O42+bMa9g5dXiLBM784Yav83sB+
         dy5Q3eeX/NakEDD2SmF7Rd01V1GTSjcMcBnLS3xyS0UgYTKSuNTTLyMr2P1FjsUyYhjs
         /VfcUk7IhYREQ4UAoOu6i9lT7UAMhNxWlDcl9cE+p+spn1zCXebfxQ23BXytvA1eV7hU
         qTEORwssr3hHKyZGcn74K1aLdTgfXTV3qhh1MkqvaRb6Ssmm4+l0M9oSD0eOePKBCK/t
         cUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wY8xzcZXiZde7TJl9Xy1dRAvvuucPAiZm9ruZU0s2jU=;
        b=brthcojd6lLR+3yxDMiobJenWsw5fydz8DQux/vIWmbGDj3/kbsnuKn2Uy9cPPkiom
         NumOVxtOZzCj+85xv3WMWQHrMN9dUcg6OV9cqcNz6DGJ9Qf4zEknb3MFN1TtzfvVdK40
         mMKWWF6AmaBhsoGnG8afCYTPX1QbTNoZ4G7NVg7i2bCKCY0QwbjPKEIOd7613QA2HMJ0
         FKSdQRbir30n1ynuAhnM/O7+nMHoRsu7ASnk59GtHyZD8YiOsnsS+YlFfWsTXl66paV1
         WqXfefR6nNEvguo3caTEGSqSRCgVk5JPBfxhelq++eLgPnRws6He/iETIh5C/OkAmnY7
         EJ2w==
X-Gm-Message-State: AGi0PuaQSbUJRHiUWlpQb4qa/ZvV20O5oI0ywYabK8bTTIrcSFOKdnvN
        tT3ur5+Hy2LCX/uxwRlIzgjkWT9wKUE=
X-Google-Smtp-Source: APiQypIVn3vPjTC9rjCBjc8tdaapVgCBM7xpsOd6SxMlPgLxpAKfHkY7+se3/KmotI9DCJIVBnuWSQ==
X-Received: by 2002:a0c:f791:: with SMTP id s17mr34986045qvn.36.1588196033633;
        Wed, 29 Apr 2020 14:33:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t1sm349746qtd.65.2020.04.29.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:33:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 17:33:51 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] efi/x86: Drop soft_limit for x86 initrd loading
Message-ID: <20200429213351.GA1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-10-nivedita@alum.mit.edu>
 <CAMj1kXFe0eEHnijuB3OGM2moHw0xH5viFvCiQ6Y0cLG7s=iHfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFe0eEHnijuB3OGM2moHw0xH5viFvCiQ6Y0cLG7s=iHfg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 09:05:51PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Currently the EFI stub attempts to load initrd(s) specified on the
> > command line below hdr->initrd_addr_max (2G) and if that fails, falls
> > back to allocating at an unrestricted address.
> >
> > The only case when loading at a low address helps is for the 32-bit
> > kernel, where the initrd must be copied by the kernel into lowmem if
> > it's not there already. The limit specified in hdr->initrd_addr_max is
> > insufficient to ensure this in any case, since lowmem by default will
> > extend to about 0.9G rather than 2G, and we don't attempt to load the
> > initrd in lowmem at all for the new device-path based initrd.
> >
> > Simplify the code by dropping this optimization for the command line
> > initrd(s) as well.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> It is not really an optimization, unfortunately. Commit 47226ad4f4cfd
> has the details, but in short, loading above 4 GB broke some
> platforms, so below 4 GB had to remain the default.
> 
> This was 6 years ago, and so we might be able to revisit this, but
> characterising it as a mere optimization is inaccurate.
> 

Drat. Ok so I guess this patch has to be dropped then.
