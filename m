Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65211D148
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfLLPqq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 10:46:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38808 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfLLPqq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 10:46:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so3255824wrh.5
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxsBMZ6WbR7V0yuuMk21Fb3OoOTmsXkSh9qn9LWUugE=;
        b=iZzwEIDi+TWzVINbxcfauAo67Jg2SQE1ZRriGcl+mSfqJ16DT6GTCr7SuTscMzxf0g
         /MVW0kE+2YtToTVoueMbRn7oC9wcWfS3q1DyjlAJnRNYZOfwz6pexJuXxJmA/hMOTubK
         mYWDx+co4CVm1qN2NfCTma8estYI7icXwCc+KDtLTKprfYpRAJ4+vAUpOAwJmgkGPZZ1
         8KCk521yBqYveb1kzxJyB110rA/yOSyjbABKc44fk/W8P73+/wBpWA6RRBuMQUWCyGzr
         D+5lPVORNXw1IIPMkn+m2L/TNS9LrbTycWBwwTb/cQVyzhxj/nryOWJTINkLXiFojFEg
         38EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxsBMZ6WbR7V0yuuMk21Fb3OoOTmsXkSh9qn9LWUugE=;
        b=GpRiEozkMgptimIeVHyu/H93lsxgOUG02a7M+0TjoObqX3eHBexhx8xwdG9muSvbUV
         8qTH7caHRvxrxH+hPDQbKRiG94Q16sZGq3EX7SNjpMfb1BmjNlppm9U9dDRXbApIEQhl
         DVfm6BvDhI9GOB0jAkPv6vUIeGvrRpgyJCZrgOFtDE4y9QUAuCp/dUAhTQhmccFZyLaV
         2SsScgmyexutabjfxQqDH+0IFpHDp4N3jd9rgcDQiDDXPJkIGY8YodpI5quPr5gwg7+H
         KPfhdnS/h/mp/IBEf+LfGzUL5vBUpuVd6Tc0WzfjsAB4p0liCM0Q8ZsZjwhYTTk7UQLi
         if1A==
X-Gm-Message-State: APjAAAXUz2wTvhwbIB0mgGJGrWstrHt1eTaqcalLmY0qWBxy/gcw4YKn
        75Tf6CiU59ytVqBioOOWWZ9y/McZJJUNxdVmMkep8w==
X-Google-Smtp-Source: APXvYqwMRwhuu8E+XbLgvlzzM2FTbIs/x7tJxkkEb6lo21GfuTVfgXBGocjpi9FnOde8dYUZjcASFfH232/ywUAOEEA=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr7281055wrw.246.1576165604385;
 Thu, 12 Dec 2019 07:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
 <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
 <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com> <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
In-Reply-To: <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 16:46:32 +0100
Message-ID: <CAKv+Gu-7H7AmMGk8_safU83KZZiJJpQ4X+o7V9Pv24AOh3g5ug@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Dec 2019 at 20:56, Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Dec 4, 2019 at 11:50 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> > Wouldn't it also be applicable in the much simpler case where the
> > firmware hands over control with no IOMMU configured but also with the
> > busmastering bit cleared.  Does firmware do this?  Does the kernel
> > currently configure the iOMMU before enabling busmastering?
>
> We already handle this case - the kernel doesn't activate busmastering
> until after it does IOMMU setup.

Build issues aside (which we already handled off list), I think we
should consider the following concerns I have about this patch:
- make it work on ARM (already done)
- make the cmdline option an efi=xxx one, this makes it obvious which
context this is active in
- I would prefer it if we could make it more obvious that this affects
PCI DMA only, other masters are unaffected by any of this.
- I don't think the presence of the IOMMU is entirely relevant - even
in the absence of an IOMMU, I would prefer bus mastering to be
disabled until the OS driver takes control. This is already part of
the EFI<->handover contract, but it makes sense to have this on top
just in case.
- What about integrated masters? On the systems I have access to,
there are a lot of DMA capable endpoints that sit on bus 0 without any
root port or PCI bridge in between
- Should we treat GOP producers differently? Or perhaps only if the
efifb address is known to be carved out of system memory?

If we come up with a good story here in terms of policy, we may be
able to enable this by default, which would be a win imo.
