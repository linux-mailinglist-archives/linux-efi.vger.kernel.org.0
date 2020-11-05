Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C32A8ACE
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgKEXcm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 18:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbgKEXcm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Nov 2020 18:32:42 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF8C0613D2
        for <linux-efi@vger.kernel.org>; Thu,  5 Nov 2020 15:32:42 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id i186so2852756ybc.11
        for <linux-efi@vger.kernel.org>; Thu, 05 Nov 2020 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlNXU8L3sc+m7lobXj6lchl7ijTptw1kaCcOIcaSPgI=;
        b=R+M6ljMb9p4EF+j7hVsSP50JIlCK4OhEmIi3kc0Oh9OJR5LX1PxyfNuxHV7xoDEaYE
         YdpO4m2sYjOBPMJz6KzYkTcEoROM/DNnXLCHIfFI/SmCDRg/sEqQVeXbtbEBup48wOxi
         Aohr3p8VnAHrN05tjYwRRNOQWEbjpjZNas1UOYx/fXIKTv5CY4SZDEpu7crHEP/b/RZp
         7cQlnjQgz2Fmpom7VisiX7UsijfBXNZT6Nlx68P+BvmK4p8szYCBc65XhRXujuBf4vm0
         arAC3YN02XoSO+Z01CbvIYBuFPshAZgA8jhXGU4p6aK6qD2dAI9kMysBuLdftf+BSuh6
         bqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlNXU8L3sc+m7lobXj6lchl7ijTptw1kaCcOIcaSPgI=;
        b=GPV2HE8IhHEB9wGMwQDNNt4B82nCmjyB/Izbtl3CWHgiUBKjky7Jg6j9hAFz0F83za
         3piqE3UwtnfCwPsSeWDmgP/WJSX84StbZpkp1yrKOZESUPSnoOUXjeWn7QNdXF9Hpt0T
         08z/svFFYsDaWWdh8KnfDiBMMZ5S2sdSwSLz+vMidTFXV5uN+M/NV3b7hiUWuY7kZSMc
         yTtXGlXPgANSOzA3J/QgkDniDGLL+z6CD/C/qzPkUq6UUKp5pJKFhsakJq3yOD5/CgwI
         2jFEzVHlNZoHthr00RE0jz2JSVutCOpx5RAnk8iZ7Zabvnbm9e48mGnlZI6ULwreGrHO
         PIDg==
X-Gm-Message-State: AOAM532mvrQ/WtxbfHMIplZM/4LEta/ulFGoTMrP5PCtN+cujtZCYcWk
        bvKBZ6+cxYmKBC8qQ/Ok4M3vpvNlsrt4MDUYd0CLcA==
X-Google-Smtp-Source: ABdhPJzzCr4BmURLVuAhnOzfU3X5o0Y4eA3x9j/YnSiCup69qb3WT2w/EdMw5wqJ7dawJsOTC6R4sqZFiyjNF8xV/bc=
X-Received: by 2002:a25:f817:: with SMTP id u23mr7312436ybd.466.1604619161422;
 Thu, 05 Nov 2020 15:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-18-saravanak@google.com> <20201105094350.GG3439341@kroah.com>
In-Reply-To: <20201105094350.GG3439341@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 15:32:05 -0800
Message-ID: <CAGETcx--D_KCpvK3b9NAQbMgWxzYT6MGEav1h2M8V7f=wK5L6A@mail.gmail.com>
Subject: Re: [PATCH v1 17/18] driver core: Add helper functions to convert
 fwnode links to device links
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

On Thu, Nov 5, 2020 at 1:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:23:54PM -0800, Saravana Kannan wrote:
> > Add helper functions __fw_devlink_link_to_consumers() and
> > __fw_devlink_link_to_suppliers() that convert fwnode links to device
> > links.
> >
> > __fw_devlink_link_to_consumers() is for creating:
> > - Device links between a newly added device and all its consumer devices
> >   that have been added to driver core.
> > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> >   the parent devices of all its consumers that have not been added to
> >   driver core yet.
> >
> > __fw_devlink_link_to_suppliers() is for creating:
> > - Device links between a newly added device and all its supplier devices
> > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> >   all the supplier devices of its child device nodes.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Did you just add build warnings with these static functions that no one
> calls?

The next patch in this series uses it. I'm just splitting it up into a
separate patch so that it's digestible and I can provide more details
in the commit text.

Couple of options:
1. Drop the static in this patch and add it back when it's used in patch 18/18.
2. Drop the commit text and squash this with 18/18 if you think the
function documentation is clear enough and it won't make patch 18/18
too hard to review.

Please let me know which one you'd prefer or if you have other
options. I don't have a strong opinion on how the patches are split up
as long as it's easy for the reviewers and future folks who look at
git log to understand stuff.

-Saravana
