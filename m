Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4462A2D1D37
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgLGWVI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 17:21:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41416 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgLGWVI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 17:21:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id 15so6068283oix.8;
        Mon, 07 Dec 2020 14:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4iKD2cvPfWP8BOC5nJukrS6VHQfTTSGGzYSJk7vjgU=;
        b=OamNyrtZ8pE4HTNcvtH7FRdoAS4E8f1zhcJHt6Il0jgL7LV8uPhaNIPW2lNGJA/gbx
         /bMMC8TuKsPmFjWybM2nJQQ6T4aImqKw7FXF8VTcQKIUajHPRaI9rOS4cYkMm2TrvbP7
         lroeHZ2eJwVyw4QTqVkxXULMdaRtKmTTtz6GNx9sGWQ5rUNwy8zMAsgREzVFMl5kV17O
         kXdH2h2w5CIE03d12vUcvhSphAfjQ4MuJPFoBEUo5bZJCc9Yo5ySzxd8ENRZfHm4ucgu
         EeAn4PaxuKyKKFUxE0WHbzwzYmRez8jWgFlvLx8uB0lVm8hp15OwxC17RWbmTPzRN3lg
         i/MA==
X-Gm-Message-State: AOAM530SiXh6NSAo6+rSjIwhErsCcpERxJFtcM/IEvE19g4kjVxRirG9
        3gOG5diU+o01zshfrw8CJg==
X-Google-Smtp-Source: ABdhPJwO0mM0n1+C8W31A2E9d9xa/LAspOLZXI3PugQ7Orrrat5gR7u20pkJ7POkklqTxyA/XVXuzg==
X-Received: by 2002:aca:ad50:: with SMTP id w77mr698007oie.41.1607379626982;
        Mon, 07 Dec 2020 14:20:26 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k63sm3256595oif.12.2020.12.07.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:20:26 -0800 (PST)
Received: (nullmailer pid 942087 invoked by uid 1000);
        Mon, 07 Dec 2020 22:20:24 -0000
Date:   Mon, 7 Dec 2020 16:20:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel-team@android.com, Ard Biesheuvel <ardb@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 07/17] driver core: Add fwnode_init()
Message-ID: <20201207222024.GA942036@robh.at.kernel.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-8-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-8-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Nov 2020 18:02:22 -0800, Saravana Kannan wrote:
> There are multiple locations in the kernel where a struct fwnode_handle
> is initialized. Add fwnode_init() so that we have one way of
> initializing a fwnode_handle.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/acpi/property.c         | 2 +-
>  drivers/acpi/scan.c             | 2 +-
>  drivers/base/swnode.c           | 2 +-
>  drivers/firmware/efi/efi-init.c | 8 ++++----
>  include/linux/fwnode.h          | 6 ++++++
>  include/linux/of.h              | 2 +-
>  kernel/irq/irqdomain.c          | 2 +-
>  7 files changed, 15 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
