Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106981135F1
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfLDTup (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 14:50:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43504 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDTup (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 14:50:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so628629wre.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4td+J/y8zL+0kbu/mhl0o3220/b/42t+qrkDa4+tfk=;
        b=OYmGaBOx0ht+4SVFQ8LShoz8qHD00vVsn9YoIESp213aFXGm3e4D9RewEL4BslOr2F
         h3yuRIZp7zblcpOsSfEMh1mlizj0lDpv7HuSC02848MWR4DMOcxC7wMy4amITCpB9NfG
         fGl1Kv3xlDMpTfBlwN9nuSZnBObMPbxfadAjbKRb9gVUAImnxShb6LQvE0ipnwt8qCO3
         ZaMj5YSrN270/2qLQLNUbCVQwFELkxg3RqFqGrzBiUEPgqLRP15yixWkAjm3N6FFb2zs
         wdDeFVQvk9J1BvCObwBBdQ+0JoTShRSkfroLKxwXGpjGVcAn2vXPzERPI6ydfmz4/GBF
         hWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4td+J/y8zL+0kbu/mhl0o3220/b/42t+qrkDa4+tfk=;
        b=LNVZMma0/NZdpBYtwDmgfPQJsD6oLqQa7DlxkgPcON/3BCHZZ80pJlEqVfRcbSr6xf
         +g4Mkk0qziTRnuQ9J0seYFcYyDRI2yEFr0RxWVEmWF3ijFNuI2y3TOunPCjY+2oo6yk+
         7TYGnK4WJDB+3wnYRll53Vt8dQNIWM3erA4Kjxtlrv3U+IqCWI5w3rza7b6PPgfwRtBJ
         J/GK1mzZptjf0y5zai+vDImm6Jxb/IQ9OM053Sx+LNxsANAE3O0fsCWUMENtjhWxpMTb
         9q/ZTRJ+mRqztR08WIKou1HyIeaVgJNniDZ/XRL+UW+CqwjTZT2+mYf5G71nNIK2bNYM
         Ij7w==
X-Gm-Message-State: APjAAAVx50kG2hkajNApX7nFM4N6aLwz73RHVZht2k2v1nnhazJXD2fz
        ybGsDAPikPtT9cPCYAV5wsYgW0W6fj/nvG/camJ+FvpaB10=
X-Google-Smtp-Source: APXvYqyfhH1mfipFn2hXP6Wg78v6VpoqDikrwF6VjZX8J/+QWbJZxgRYeoR7HdjjJHf5hWk9qYLs4gNjoa/mpfyXGfg=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr5792679wro.195.1575489043186;
 Wed, 04 Dec 2019 11:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com> <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
In-Reply-To: <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 4 Dec 2019 11:50:31 -0800
Message-ID: <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 3, 2019 at 11:41 AM Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 7:30 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> > Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> > is busmastering on when the kernel is loaded?
>
> It's only relevant where firmware configures the IOMMU but then
> removes that configuration before handing control to the OS. I'm not
> aware of that happening anywhere other than EFI.

Wouldn't it also be applicable in the much simpler case where the
firmware hands over control with no IOMMU configured but also with the
busmastering bit cleared.  Does firmware do this?  Does the kernel
currently configure the iOMMU before enabling busmastering?

--Andy
