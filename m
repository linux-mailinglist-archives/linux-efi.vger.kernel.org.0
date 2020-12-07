Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E24D2D1D70
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgLGWiS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 17:38:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41034 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLGWiR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 17:38:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id x13so6601670oto.8;
        Mon, 07 Dec 2020 14:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3cIyQo11YcV2d+VVt0gP2O2Kn/VUN0Eh4XV6fvTHwXE=;
        b=Ui1Agf8DHUKJIIY406AUQ74M64c7Q/g4ffQPk1XK1XyO3DGAFtXSXiJZjP1xhGwugL
         wsKJNf+POicyrJTIxQrggPvbpLNNSNbslp/3wq7+8UCh2U1TOb6dQsS9MsTarHZ1JhGZ
         Nqh02VjjPUjZ447lEPBL7BaQ5IqX40p/DLt8HLmIV4gkc3N+OBN+3Er/ugrKLcws4SKr
         Cvnck9/pkBPsUzsSb64Phof8ckeci0P3M75uQyprcSzjHawvuLopNE9m47Lc8AVYbOXX
         RPNm29qiWVDdrmdoO2peRhWAmvWHNV8SgOcQAXhzo3956UFvpa98P5x+7d25J7rArIFq
         Qhng==
X-Gm-Message-State: AOAM533ev2m3GVRMZ5eHySAzQevMqX0Qc8zBG7sCBvKoux79vMEw7vq8
        2RVHjDPPVtDJRzmXZpu3uA==
X-Google-Smtp-Source: ABdhPJy4OeTyT8HggBUqqtdc5RO/n2QhgB6G5Im7WYsVVAMbL5Bg9yqMRxWv9yoxye53+XOutJZSag==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr14070471oti.230.1607380656678;
        Mon, 07 Dec 2020 14:37:36 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v13sm3275153oic.17.2020.12.07.14.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:37:35 -0800 (PST)
Received: (nullmailer pid 970089 invoked by uid 1000);
        Mon, 07 Dec 2020 22:37:34 -0000
Date:   Mon, 7 Dec 2020 16:37:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Len Brown <lenb@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 14/17] of: property: Update implementation of
 add_links() to create fwnode links
Message-ID: <20201207223734.GA970033@robh.at.kernel.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-15-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-15-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Nov 2020 18:02:29 -0800, Saravana Kannan wrote:
> The semantics of add_links() has changed from creating device link
> between devices to creating fwnode links between fwnodes. So, update the
> implementation of add_links() to match the new semantics.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 150 ++++++++++++------------------------------
>  1 file changed, 41 insertions(+), 109 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
