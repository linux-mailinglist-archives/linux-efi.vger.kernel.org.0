Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA402A8A98
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 00:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbgKEXUc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 18:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgKEXUb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Nov 2020 18:20:31 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E502C0613D3
        for <linux-efi@vger.kernel.org>; Thu,  5 Nov 2020 15:20:31 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id f140so2857536ybg.3
        for <linux-efi@vger.kernel.org>; Thu, 05 Nov 2020 15:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3KvjLX/VJORZkMvx/1zYSVzh145Bb5NCA0EOT0E+co=;
        b=Qv4uKSRPKxySPqftfzvwkAWHZJ/wyt516/Gw/2AspIpjKZtwdgTxvcR5AzgtvXTrsu
         7GoPjn0++JJ8shAHCAfP4oBYeaZT1BMj9MVcQAuLLLYhxyl/1QR0cc9MXCtyvAQemcnM
         bEqyhD9qFHSdTcI034xskJwUA2Cffn+3FDNY4sUmBGlu3VwlfKXDKTH4LK5NZHiWofKb
         2F2hFKH9Rn/7KJx+F9DibitQVHzaoYxvN+KaxY9u9L0GLMEF1zk92TEkx3gdy1pnTYEq
         4NEnDIwskqLl7F2hCoI2cyu8CLaScCwJcYn5HjRyNTXLzLtrM4yj7DPNgT6v5VyLueEe
         xguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3KvjLX/VJORZkMvx/1zYSVzh145Bb5NCA0EOT0E+co=;
        b=UwvxRUT59obhUykwUHNR/2pEe8+qBye9wyHQ17X9oMNuAV+HXvRN8UM1WTrFA3JUV5
         2ihe0o9GFuyR35fh+0zspFJ2cFH1dWj8W8wAfKeMlQNWm9EoA5gLjjAgAXmW4BwuBBvH
         rLVxzOBE7lZjLJwoqKQVsTJ6qfufv/RpWoMBrkctM0ehgm6O+K/Ffci8Q53rFhrrHa9p
         HIaBgJ515cP1Jp3c7MN0FSXRIDQ0Q0zpRsfKWmmI8tCUfhsEWX8Aqgj+HIrF9KoT5Z4H
         vJdFVH5PCTyDbRywxFfPeazKWrTTwE52A40tuAplQngNoEzm8zAVxpez6EYdnyFfDXTT
         QjHA==
X-Gm-Message-State: AOAM532Q96M//au8Pb8Nfq5vKtkEG7qzVWcmcq07t6XJaVXAl7acFRze
        GrESI6hQUnPeT2haBKmDGdAvVwZ4LiL3c2sT0A2O8A==
X-Google-Smtp-Source: ABdhPJwNPaIyrXj+5IuUPWsE7V5EABEILCdO7q1BovAOrT9z3Fn8nD8DbzEs7xRgXUqoLjsotAsX31QeSdVbUoTK3ik=
X-Received: by 2002:a25:f817:: with SMTP id u23mr7258013ybd.466.1604618430227;
 Thu, 05 Nov 2020 15:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-2-saravanak@google.com> <20201105093413.GC3439341@kroah.com>
In-Reply-To: <20201105093413.GC3439341@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 15:19:54 -0800
Message-ID: <CAGETcx9CZp-yyRwi=27eU7hf3z1uLYhaOrY+iyZYxsNpxhLLAQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] Revert "driver core: Avoid deferred probe due to fw_devlink_pause/resume()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 5, 2020 at 1:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:23:38PM -0800, Saravana Kannan wrote:
> > This reverts commit 2451e746478a6a6e981cfa66b62b791ca93b90c8.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> You need to say _why_ you are doing this, it's obvious _what_ you are
> doing :)
>
> Same for the other reverts in this series.

Sorry, forgot about this. Will fix it in v2.

-Saravana
