Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEB12D462
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfL3UQv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 15:16:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39757 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfL3UQv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 15:16:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so11455210oib.6
        for <linux-efi@vger.kernel.org>; Mon, 30 Dec 2019 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGoYHJkV2sBuC/EabEMn2jT6G42n0LQcEtNTThbzJvo=;
        b=LOFA+mxlmd5oV8l+Ly2ITiGE7quCUFquXLsCfnDW9MllcsxJM+xgnpfdFKisb8BlW1
         GsO5VONykMGvsC/iRi6Eid6vExDoXX/AGXk3RgaQSaV/KJstjudxFNuYhLaX/O/sRVgI
         fCl75NApfe3sM2ibIn7p9xCxDkpU9lBZeIiHUmzhr+s8RGLjZMMlrnEOtoVPjzn7bz+8
         qAXlEZ4WIdspGkErzVHHtXGP+qBfG7Ig0sNFiB5LEExIhOb0uo+rkIgNuo/eDxEcTcVA
         mHuU2UpXe/KNqH19ffb+XBrtbUJmugSY6caSLnbRawTieig0KcwDS3330Y27EYSFO6nG
         GO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGoYHJkV2sBuC/EabEMn2jT6G42n0LQcEtNTThbzJvo=;
        b=U+UzU0yaw4G/q5mRROsM0B/cu73z6e0k766XJ/SZrQyc45MZhgPIEP/GQKq0p3Eux6
         i4ZAez26cUdo8cVwpi3QlvAkflilTInSCn7lCbkyO0epHeu9mThnUbbG4b7an+mtyqQM
         TbRxtC6/Bs6iDnjk7ScsQn7uDnaQRqw0c32dyPsAzx//rM6KFl553IIZEiBfluBU32bN
         XYr/hpHaJER+C3A0B9kECwNUWc1ZpbO3AYkN7/LxoltsgXF6d0NqcnjtcM/vh96NP0mA
         qO3wh+YltvVR1CZwSiwJQnK+pwzJShw8h4bLcxs1BiEoeOTWZzpl1QDkvwnl34/ASJ18
         D0vw==
X-Gm-Message-State: APjAAAWyu7yjf60UnYmcja50Iqsz5jFwF0nOEvQx6A69CUQgG9XFC20d
        Nv+3sO0S9IAkC0S7x2v6ArC3JVel47WFOJ+d8D0ZHg==
X-Google-Smtp-Source: APXvYqx3ceamtmJUChp1TLuDkDv4af0iLI+bwyDSS+upKsqsk+U0Ob0XHRDXqZ29dmIwB0CA1zn0kxN2oJlTNMRltC0=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr333228oia.73.1577737010159;
 Mon, 30 Dec 2019 12:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com> <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
In-Reply-To: <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Dec 2019 12:16:39 -0800
Message-ID: <CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
To:     Dan Williams <dan.j.williams.korg@gmail.com>
Cc:     Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 30, 2019 at 1:42 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> I'll send a patch to fix up efi_fake_memmap().

For others following this thread, that patch is here:

http://lore.kernel.org/r/157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com
