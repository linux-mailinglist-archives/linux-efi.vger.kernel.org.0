Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D12D1D2B
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 23:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLGWTm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 17:19:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41292 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLGWTm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 17:19:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id x13so6556419oto.8;
        Mon, 07 Dec 2020 14:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZKhfx3NhHu0s9VdxWbSkTcdq8RyzWd1eXTRURQA42U=;
        b=uNC1fYjhRe1nGN577P3WRT07TfwKGd/31SpBqklbUfI8+cch/1Lcq1JQiAiKL4wQaZ
         XxT0Jc5VasP5McXldj0Zo/oSE5wslXmSeF756dpik3GTCPaxH+XRYJA4RR/4fjSS287c
         oRKMVaisTq8N4I7BUfCzUgVrtUqhRZfqIyfGmD2FeXx5fky2lCS+IuFT6UnT1rJMnAbJ
         hMEXYGen0zMtXWg+tuvjmolXugduz/PYw8h5loqYrhAA4dU80YWPgcRwd7JX6XVebGEa
         t0uZoaVN/9GMaFJQYwjIK4nAUgvbVUE0QfcdN1H9/sadGjh+GErevNTia+A+703BkAFG
         WqkQ==
X-Gm-Message-State: AOAM532vAop2MeFNK18u5jxhDkqhm2O0/5l41fZUbJ+hrzFfnRGPBogq
        Bd4rnTA7OW/TwrGHXqOltpEX4a7wLA==
X-Google-Smtp-Source: ABdhPJxHXRa3j5HUGgK15izJhjWf/NygJzk2HZBGz7xU8L8umdpNwW5068ob9RSfwRlp6q70jttHPA==
X-Received: by 2002:a9d:5613:: with SMTP id e19mr14470041oti.153.1607379541557;
        Mon, 07 Dec 2020 14:19:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y21sm2960829oti.21.2020.12.07.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:19:00 -0800 (PST)
Received: (nullmailer pid 939846 invoked by uid 1000);
        Mon, 07 Dec 2020 22:18:59 -0000
Date:   Mon, 7 Dec 2020 16:18:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 05/17] Revert "of: platform: Batch fwnode parsing when
 adding all top level devices"
Message-ID: <20201207221859.GA939790@robh.at.kernel.org>
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121020232.908850-6-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 20 Nov 2020 18:02:20 -0800, Saravana Kannan wrote:
> This reverts commit 93d2e4322aa74c1ad1e8c2160608eb9a960d69ff.
> 
> The fw_devlink_pause/resume() optimization attempt is getting replaced
> with a much more robust optimization by the end of this series. So, stop
> using those APIs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
