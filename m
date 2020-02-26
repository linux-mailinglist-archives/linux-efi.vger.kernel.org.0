Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34AC170AA7
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 22:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBZVlH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 16:41:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39988 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZVlH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 16:41:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so1102406oii.7;
        Wed, 26 Feb 2020 13:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5y+3yyZEWJZJusOCBHvZyULVHwwLi3nzMEYeDWLDUk0=;
        b=QVwSy5G7heMV1vkOmeNENTnB/h4EErr3EiS2Fn2eE5S63d++ppeEM5FXT/2LhrE5y0
         DrnxTWpNm/qmh6i3YiSr4sAMgtbZwrCwP7mu5e37OQV6NzbBOZGVqBbGBAsFdqwHo7Vx
         2usPB9ce024NV6LRtWqTvlfRKljOc+/sq6Pli3t2KRV9tNm/v0x3yXyPc52DOmcY36gQ
         lFvCIvfYxcu3fvKNGUmeCF0dznPQza2LIYq4yZFljzoCPdIzoGPllLJw568JvcITiVza
         yZHSIrbFItQ1f2QLRhs9+EtMeLPldJ/FJP1FUiJV6sfVx9RHLUPpIVoTYHr+jvOWp7E4
         Nveg==
X-Gm-Message-State: APjAAAUmR84ZCcRUw5XyTio6ewC4utPi+av1bJPyXnjeHB+e41kjISmP
        wkUzEv3aB8sGPjKb/257eg==
X-Google-Smtp-Source: APXvYqz40paWj0yChkMjb+Ax6JzRcdMeIRdfuPwxO6dYs8zg8mwm2gYxPDtbGGusYkkBTw4I/BlvEg==
X-Received: by 2002:aca:4f4c:: with SMTP id d73mr874490oib.107.1582753266742;
        Wed, 26 Feb 2020 13:41:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 96sm1221380otn.29.2020.02.26.13.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:41:06 -0800 (PST)
Received: (nullmailer pid 8489 invoked by uid 1000);
        Wed, 26 Feb 2020 21:41:05 -0000
Date:   Wed, 26 Feb 2020 15:41:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] of: property: Delete of_devlink kernel
 commandline option
Message-ID: <20200226214105.GA8431@bogus>
References: <20200222014038.180923-1-saravanak@google.com>
 <20200222014038.180923-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222014038.180923-6-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 21 Feb 2020 17:40:38 -0800, Saravana Kannan wrote:
> With the addition of fw_devlink kernel commandline option, of_devlink is
> redundant and not useful anymore. So, delete it.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ------
>  drivers/of/property.c                           | 6 ------
>  2 files changed, 12 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
