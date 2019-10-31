Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20307EABAC
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJaIlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 04:41:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40664 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfJaIlb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 04:41:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so4942230wmm.5;
        Thu, 31 Oct 2019 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjs9ihZ0Cud86vWdYvO1bLBBEMUDpzpRxE2xbMyX++c=;
        b=oNhYdM+4DuX5+jwvMxQuyPajQ/FyxCDE0/I+kO9QaCw0UyfhDJGWhyDZOE3I63rsNM
         gIYBq4Suu/G+5ImLqgvC8SiR9F70DhfnPcXSeL1iGYlUjYwifcacRnMGDzQPYCtuX+cS
         l/M7aoFK1euHZ8I9HrmHth7m9H0Tb+Anlfc5nOQrVGxTUBsSv94oy/VOD8YpodSyzl8R
         t3XK/cA6qrArNBArP5ERYIPUeD10oxuVnmwVwp8AUtx7lOB1uee87ui+WZbi8y7lY45R
         NLUe/vzuGqbPVSyyaFGly5OYOYgAOLOWZsBOPivxqzGlHhHKfFSMkVy6/kVRPwvsE3WS
         +D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjs9ihZ0Cud86vWdYvO1bLBBEMUDpzpRxE2xbMyX++c=;
        b=sV0+bEoIRNkF37NqD/t20XIcCnqKyQwYFTqzWwMJ0oDmcoR2G8Q9AH66QYL8cqRt+0
         kSSCt/FyhV/DUKqLyWv/zty5Svfe0DlfUBG4o2LJ+nAabMpmQxYopa3VwHT1LfLA8UIA
         +h3itBx+tcQ/RbBIw3Yo35bWHWnGWm1+z1EWkguj0sCqI/z0swbC+N0sS0NAXwmmFFgs
         Rp5EZ4CdvqUz57AJY4Bs/W1LuSPSelGN/Sd6RO7ENgXwM7sbsdvfEGhClQr2iEkebMNB
         eOar5UZRvfiIK/6wFr0O631GBcZ3CuxUp8TBpOcLAB90mUOoeE/EFFWSWmIb76g08wE1
         o9/A==
X-Gm-Message-State: APjAAAUIpwhcVlucj6pzwXDI/hEy8fhILAUi+8yMAGyQGCYd2ffg7dnK
        QbdsVUqME5SIE6tIgglxqek=
X-Google-Smtp-Source: APXvYqxXsa353WzGxLLSJ8LO+SGP6PoZI+zx/b+nV1f7dHOqC6OHvdz0emGxnB6ZGebYvp5WOBJ1+w==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr3784066wmi.56.1572511289037;
        Thu, 31 Oct 2019 01:41:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d16sm3127628wmb.27.2019.10.31.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 01:41:28 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:41:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
Message-ID: <20191031084126.GB107774@gmail.com>
References: <20191029173755.27149-1-ardb@kernel.org>
 <20191029173755.27149-4-ardb@kernel.org>
 <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
 <CAKv+Gu_zMMeRSBYk_tBX4UA+v1r+Kntrxe3xurLd1Q2_+HkbWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_zMMeRSBYk_tBX4UA+v1r+Kntrxe3xurLd1Q2_+HkbWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Tue, 29 Oct 2019 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >
> > Hi Ard,
> >
> > On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > >
> > > Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> > > add_bootloader_randomness(), permitting randomness provided by the
> > > bootloader or firmware to be credited as entropy. However, the fact
> > > that the UEFI support code was already wired into the RNG subsystem
> > > via a call to add_device_randomness() was overlooked, and so it was
> > > not converted at the same time.
> > >
> > > Note that this UEFI (v2.4 or newer) feature is currently only
> > > implemented for EFI stub booting on ARM, and further note that
> > > CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> > > done only if there indeed is sufficient trust in the bootloader
> > > _and_ its source of randomness.
> > >
> > > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > [ardb: update commit log]
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Seems my Tested-by was dropped which I provide for the RFC version of
> > this patch.
> > See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
> > for details.
> >
> > I can provide a similar Tested-by for this version as well.
> >
> 
> Thanks Bhupesh

I've added Bhupesh's Tested-by to the commit - no need to resend.

I've picked up all 6 EFI fixes, will push them out after a bit of testing 
- sorry about the delay!

Thanks,

	Ingo
