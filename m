Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAB2D1D84
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 23:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgLGWiy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 17:38:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34720 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgLGWiy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 17:38:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id h19so14151051otr.1;
        Mon, 07 Dec 2020 14:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=180dC8MA8XhmHcl6LPa/ct6qoxmSvA8KJAYrKrg4o6o=;
        b=SqvgMqT1wjCy68nnpjvEimD7S++5yVJTnF9Qp0YZaHdUyPp6jcGrxS20AYs8xTEm2O
         vbYB1X97Z1V/FLEcvio2E8xjpgNjWidGZBRzKAkfqtMk2Z9mNbBJOeN8MKD/WxUWu/1l
         CHTaBQBgpF2fPKBQTU7ZhNzaTlfi15ZwSEBt7I1yGWOQLZHs8gstq0zU+TKyoRH9gJ01
         tARhmbn5yHGlWG3xRyvTq0hgbRn0F4pQfNSvofKjn6JdlCn916ckf+SNXDEGXWBu0ZPk
         FsQwii0eVRMQKOqmIokfMTyX1w8NjNnarANr9L/qxx8TFVNS2fSNR/kezMoWVWau+qPs
         TMtw==
X-Gm-Message-State: AOAM533TQuL+N2uwH6qs8HP7F6DyN/z9ooHylyA3Gd8gl/w+G/Qe7xyg
        xPhtbGfV8wUAN6HlkZeK0g==
X-Google-Smtp-Source: ABdhPJykcrsL0D8IMYg2/kYkb9R3Pr72ZsKMdicn2VFLYguiO6t9u8bdpFJw1rAzmwlMshEwJPQFhA==
X-Received: by 2002:a05:6830:1501:: with SMTP id k1mr9591213otp.12.1607380687344;
        Mon, 07 Dec 2020 14:38:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g88sm2667237otg.64.2020.12.07.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:38:06 -0800 (PST)
Received: (nullmailer pid 971001 invoked by uid 1000);
        Mon, 07 Dec 2020 22:38:05 -0000
Date:   Mon, 7 Dec 2020 16:38:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        Rob Herring <robh+dt@kernel.org>, linux-efi@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 17/17] driver core: Delete pointless parameter in
 fwnode_operations.add_links
Message-ID: <20201207223805.GA970925@robh.at.kernel.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-18-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-18-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Nov 2020 18:02:32 -0800, Saravana Kannan wrote:
> The struct device input to add_links() is not used for anything. So
> delete it.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c             | 2 +-
>  drivers/firmware/efi/efi-init.c | 3 +--
>  drivers/of/property.c           | 3 +--
>  include/linux/fwnode.h          | 3 +--
>  4 files changed, 4 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
