Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CCF2D0169
	for <lists+linux-efi@lfdr.de>; Sun,  6 Dec 2020 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFH1G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 6 Dec 2020 02:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgLFH1G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 6 Dec 2020 02:27:06 -0500
Date:   Sun, 6 Dec 2020 09:26:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607239585;
        bh=eqcGbi+bzpXI+QxMqZZmEGfj/8nMkdEv1Sz6YIfWTX0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dqi8PZxuE3DuSBRJy+QYqnmWJGwfvbEWdldxNTJna4+fd9CKaUf6QwE4h6xH4GTh0
         uQ8K0D0XjXbuXFapkkOVDyYVsnbsv1oO76HuuGEoudu2Apza+PkdUK01saQoNmq3bp
         3XezgK2+Y8ytR1Rl11xPvBMAIUYkNETSBLB9vsELQqIWjFpG70/2Bfkl48POSPXR1L
         myAsiVn5001r972jLLI43fvGQb2zIASjqWMONBJZR869g1YftSB5aQNoPAsi6+uJsX
         PgjmV7fGBlsQ7Ma2kO9vetJrHAGc8WEw3u2svv4P8XcqSR70P68d7SVihjs5UhQpbf
         HmDsxgUsmZHbQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/17] driver core: Add fwnode_init()
Message-ID: <20201206072621.GA687065@unreal>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-8-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-8-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 20, 2020 at 06:02:22PM -0800, Saravana Kannan wrote:
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

In this series, I didn't find any extension of fwnode_init() to be it more
than simple assignment. This change looks to me like unnecessary churn and
obfuscation rather than improvement.

"...ops = &...;" is pretty standard in the kernel to initialize ops
structures.

Thanks
