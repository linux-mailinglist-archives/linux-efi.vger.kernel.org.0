Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F742D1D3D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 23:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgLGWVy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 17:21:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32816 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgLGWVy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 17:21:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id d27so9723101oic.0;
        Mon, 07 Dec 2020 14:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39td7MWAI1dABVTePGs2wjZlZAtxzRyqb3mgk1Ytfpo=;
        b=D9QfnFc/Vk8xvILdIBa2S8jv9qMIHd5y+icL0ViHU+3RZ03kZtwdlMlLE2tuvr//La
         /PItErjcYv+AGEhLehxfpGkJWZNML0KdX95QVgz2H9/4QbcRVzkZTCcaE9J8kjQZC/iv
         /I/8n4Nj8Fr3Oq3qd4Ba0bRRFjaDCqZgc2k33r2zeNb60w8eBnZPoBG0yNglxyVaqOmX
         B0Ls9VaxAJwQ2bNIF9yzzuSFmEicrdH8lS4FdaNiVe5gGIl5I/QsyOptPe43NUJjOfyN
         duQaRV6COkcdjZPSqV9ljH0pksahujFdLO8wpUBKsryazlGTBsHsClnHZqLVQPOut8eA
         Rs0g==
X-Gm-Message-State: AOAM532fJzeoqZeghW1g3j3KGSSBkpWmza4FEeE53ABoM9jreaTdSj0Y
        4jB+LraAfPCC4VUYqeNksg==
X-Google-Smtp-Source: ABdhPJxi9QKOrQ7Wrnovkp/De8mp/bzEqu6JAct0eOqh7QO49YsGLaDZWFStImqMukaXKcN63qLJ4Q==
X-Received: by 2002:aca:ef03:: with SMTP id n3mr699440oih.75.1607379673230;
        Mon, 07 Dec 2020 14:21:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm1247490otk.58.2020.12.07.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:21:12 -0800 (PST)
Received: (nullmailer pid 943398 invoked by uid 1000);
        Mon, 07 Dec 2020 22:21:10 -0000
Date:   Mon, 7 Dec 2020 16:21:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-efi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marc Zyngier <maz@kernel.org>, Len Brown <lenb@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 08/17] driver core: Add fwnode link support
Message-ID: <20201207222110.GA943340@robh.at.kernel.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-9-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-9-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Nov 2020 18:02:23 -0800, Saravana Kannan wrote:
> Add support for creating supplier-consumer links between fwnodes.  It is
> intended for internal use the driver core and generic firmware support
> code (eg. Device Tree, ACPI), so it is simple by design and the API
> provided is limited.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 98 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/dynamic.c   |  1 +
>  include/linux/fwnode.h | 14 ++++++
>  3 files changed, 113 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
