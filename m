Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADF4530E8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 12:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhKPLjK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhKPLiM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 06:38:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984EC061226;
        Tue, 16 Nov 2021 03:33:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so26440668edd.3;
        Tue, 16 Nov 2021 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg2qQ+8bY8ufKfe+mg2NqMGPkH16u+/8Lo+azxIiQEM=;
        b=LNN1eGhJB1qFU175DGhQrq6OtLMKjQIcWWJ6lUVIXvSSJNnoUvLjltdB0Fp6Dllusd
         vr8Iflxtp3P2wMLXGm90ENGrgVcBKX9WoHe8VxsnrG8abCuQOWHb2OC0agvYcKwsYPui
         PS715cyhtWvkC1YgXcDs9+d60GDkkvof9d588a6e3z0yVUeBvX7UNnR71oPBo/PxX53Z
         kNY9nLM2DxOXf3MxVlM12KlgW5VhZaU4DqxsjnXSY43QJGwUqAJqVRpjksH5+RoWwzG2
         0VKpaWTnXhjElObKzpEqydUSOHu/2TAt3Gf2/EUZqs5DpxsEW13OHA7/A9DM4g66XXrA
         Pm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg2qQ+8bY8ufKfe+mg2NqMGPkH16u+/8Lo+azxIiQEM=;
        b=Nl6DCITP4vVKKtU9NJ3DqjG+XljMaNdlQVJKnL8peReRD/cZuEZk6mGSwW3shdpTBb
         qw3nnSLQtHUiqFQ4mTc2dhmydKm/2WvlhAZViseJ4NuZiks94h+JoyYL1Sx7tbIvTulU
         a/vpoPonXyrlEB50EC7J7Zy4z70vvv4bgaiTHNaEbBXfM+j6Pe8fKGQpBW6eAEWTGXv6
         BLF7HSFlW7Gwgot5EeUxhT2NRr8M3MiARlcOtUbbXr0pnv1NSIMzh5GIEKBiEFK2ck8l
         REeX3mbq/RO+FQ59sbgej8E4ozI5TTmabRMjZfii4mKJQHZn2czrVF36GSMTuZq0j7bd
         QX3A==
X-Gm-Message-State: AOAM532hQ5ncdK9hPbeitBbm39uvTAZpFHpEHnrai0cVusLTsOVt1+GW
        P/5z87oRIm3sGfOunLQE6SfZ6Wd7/wzMIK0Y/Gk=
X-Google-Smtp-Source: ABdhPJy5CPnYbv9nPe3hG14+wjS55LvjM1FewsoXlmHHMp6kood0np5yecGCwdIvRDNawCS5RGHzr2eW+6sOxbuejI8=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr8678631ejq.567.1637062384713;
 Tue, 16 Nov 2021 03:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-18-hdegoede@redhat.com>
 <CAHp75VdXSdhNtPwNdpssnmt+sZb+ZoAUm-cKJu-PqymmHMOpRw@mail.gmail.com> <CAHp75VfSwf0SKDHDOG7WO9xY5Q52o1Zw2GPkxi7UnrLhMtiobA@mail.gmail.com>
In-Reply-To: <CAHp75VfSwf0SKDHDOG7WO9xY5Q52o1Zw2GPkxi7UnrLhMtiobA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 13:32:23 +0200
Message-ID: <CAHp75VfTsQTxTSbBDBqncJha0QtOptK0p5k1jy2Ta-HURu63cA@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] extcon: intel-cht-wc: Support devs with Micro-B
 / USB-2 only Type-C connectors
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 16, 2021 at 1:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Nov 16, 2021 at 1:28 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:

> > Can be also written as

> Oops, other way around, of course.

Yeah, scratch it. We have nice debugfs which will be missed...

-- 
With Best Regards,
Andy Shevchenko
