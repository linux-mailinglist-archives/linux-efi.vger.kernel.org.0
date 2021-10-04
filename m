Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DE421628
	for <lists+linux-efi@lfdr.de>; Mon,  4 Oct 2021 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhJDSPa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Oct 2021 14:15:30 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42951 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhJDSP3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Oct 2021 14:15:29 -0400
Received: by mail-oi1-f171.google.com with SMTP id x124so22729592oix.9;
        Mon, 04 Oct 2021 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MmG9UNeaN9rX2Xe0UpnHbblcz68hViXX139qRa5xqs=;
        b=CYMDUgQVW7UT0G1bG4WG1rXhKfJBnAgcadn8Vu1u+BcLNU7lrvQmKBdOACNByaPjNG
         P8gDlGn+lGyXIR/fQgTVxQfQQ/J8ED6L23xq9uVlshYBP9aVKygbxKEw+gx0Pbzm21Sw
         NuxiW1cfYFUejxt719WxOpSiDUXdpXkb7cAiiPL+PWIZqAVseYHWqx8/zW/Fz6A31iig
         +dcKv4CJArG/gHwSSJb55UtxRqlVdr/5jV5iLuyKypvJglKutnChHl+N38Ps76gXu5ET
         piItricQ+XmtiXzk5Zkn61kNQdu/jrlr1J/aBC4sVGeXE4aA+H9SBbiOLy0rnOS3ygG3
         KB/w==
X-Gm-Message-State: AOAM533FpsN/+55MoDx+J6TACs5a9rBRreNxynWfYJzrFdnu6ut9X1JQ
        3YHqC7pgDE/9Ab+fqt+O8g==
X-Google-Smtp-Source: ABdhPJx0ioUdg1qmUioj/6ORoTI6fqApCcPadwhZIZ/aH8TQKsWdiLD5MArO3D+E2krV4WhpTIUqEA==
X-Received: by 2002:aca:1b09:: with SMTP id b9mr14672812oib.55.1633371220108;
        Mon, 04 Oct 2021 11:13:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm2973690ooa.36.2021.10.04.11.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:13:39 -0700 (PDT)
Received: (nullmailer pid 1588507 invoked by uid 1000);
        Mon, 04 Oct 2021 18:13:38 -0000
Date:   Mon, 4 Oct 2021 13:13:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, catalin.marinas@arm.com,
        shan.gavin@gmail.com, will@kernel.org, rdunlap@infradead.org,
        maz@kernel.org, linux-efi@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation, dt, numa: Add note to empty NUMA
 node
Message-ID: <YVtEUpIFdOrIoH0B@robh.at.kernel.org>
References: <20210927064119.127285-1-gshan@redhat.com>
 <20210927064119.127285-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064119.127285-2-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 27 Sep 2021 14:41:18 +0800, Gavin Shan wrote:
> The empty memory nodes, where no memory resides in, are allowed.
> The NUMA node IDs are still valid and parsed, but memory may be
> added to them through hotplug afterwards. Currently, QEMU fails
> to boot when multiple empty memory nodes are specified. It's
> caused by device-tree population failure and duplicated memory
> node names.
> 
> The device-tree specification doesn't provide how empty NUMA
> nodes are handled. Besides, I finds difficulty to get where
> this case is documented. So lets add a section for empty memory
> nodes to cover it in NUMA binding document.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  Documentation/devicetree/bindings/numa.txt | 46 +++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 

Applied, thanks!
