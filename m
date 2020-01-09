Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5913611C
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2020 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgAITdB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jan 2020 14:33:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33850 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbgAITc6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jan 2020 14:32:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so8447737otf.1
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2020 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15Z89BEz3MyoZ6v5HIMpK8EJU4eXUmvvtENLzMT47po=;
        b=dV4vHbO3yJC1YETzxVL8c6ZqJvPK9/XcK4jmRax+j7rcA7nRe6Tg5p7OfTgAMVhZxj
         e5Z5Wz8HFFnS/PXc5hVscrwiMThqKeZZ1RlE97vx/ne+T3jFL6xiKrKa7+wn04fW3D8P
         4HxzwPNHX2cV8MwihYbe3NTfU6UU+isJM2TQyQx0nsSf8MLY4U00rc5+n0z0LxSifQ49
         lpG9eFHrMCgEfgnF+hQ9i4kDziMqVe8WLeI9l/ve93HrMOh1zJ737sTQeqUZ/ZA0uVYI
         iD/QwSOGX7LLSmYE2fJ9xkCp4ULxjKOvURfi9psbijceK5Bpevv4hGaK622MC6wVDylv
         X3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15Z89BEz3MyoZ6v5HIMpK8EJU4eXUmvvtENLzMT47po=;
        b=quOFj8yUZg1Z8JmLDi5j0H+i1c1oyJxyxEg3+StNYyXF8pBSuLDP0TLl7DArJ/qCXa
         1/U+L66OG1gsbcPbDOZzB/C8l0hlbf3r21IUw2fVYP7dZSvY1zSz7SI2I3GzGBKtCvD3
         c8h4dKKVCO5n8mpNUw7TW0LakQPyTp1Ht5/DO+Iz5ix7QQ2mQkLaqjsF8WyxWVJUe3Sq
         AASO8IsvzBeyO1jiNk9OJPsnau/CgjkUDVGffe5dkSWcENRSzN7InYoIfTlaTzMvf9oc
         Pdq2lGPBf/n5z3WgETBVAU2/4R6dzl6MZBZONTBvwWAD6txiDUgkvSvzXJXZ5ZkuL9CY
         S9vw==
X-Gm-Message-State: APjAAAWMKjYOU8/NSOR9bJvDaETYrrt9VM4Jr2o050BIGnk32ejWDLeD
        tfswMOdcub7iyJBWi+q3jCoJ5eVzOiJUKmobBf4JeQ==
X-Google-Smtp-Source: APXvYqwP3eFYrodvtdZcfAfAqu8xqamJQA9sIs1h0qRh427F+yfPvleK68+NS8Lx2t66bO7knqd07EAla5mtgaQWbio=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr10115311otk.363.1578598377813;
 Thu, 09 Jan 2020 11:32:57 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com> <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
 <20200107051919.GC19080@dhcp-128-65.nay.redhat.com> <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
 <CAPcyv4ixPchDOet=ztRQxLMgnJf9DauSFgBs3+TEoaua7R1s_Q@mail.gmail.com> <CAKv+Gu8W_EyMNAtDG6zK+dKRcaUEzeJ3fmPAiASdqatD3ewQJQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8W_EyMNAtDG6zK+dKRcaUEzeJ3fmPAiASdqatD3ewQJQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jan 2020 11:32:46 -0800
Message-ID: <CAPcyv4gjLaDgV0rVttrWHivkzPJ+-OesT3srNomENmT8_FhmFQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 9, 2020 at 1:36 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
[..]
> If it's just for the comment, I can just slap that on, as I already
> queued the patches with the fixes tags dropped.

That would be great. Thanks Ard!
