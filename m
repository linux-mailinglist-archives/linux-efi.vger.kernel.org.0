Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E666542162C
	for <lists+linux-efi@lfdr.de>; Mon,  4 Oct 2021 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhJDSPh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Oct 2021 14:15:37 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45638 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhJDSPh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Oct 2021 14:15:37 -0400
Received: by mail-ot1-f43.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso20504128otb.12;
        Mon, 04 Oct 2021 11:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbdWS7O+5glk2eGl8y+sbYBXK1dhg+jDTiIjq/zLXkk=;
        b=l51gM3fAPOQpD/ychRx1JlS7HRsSCUZwTBHW5R5bVnoi95LbgCHUmwF3nZsTyhc5Gu
         QCBdTRC7lgbAo2eg6aab/1oKs237pzxBN99vBZCfZ8ax4nzllzIU1ch3gbSlkKi8VwWQ
         P7pj/qqENrIK+PCLR5ncBu15Y9+Izej5P+IA8F8tv7ebIKkw5P9H0nnM41Nc5idS+Oit
         Q5aCCjomvs6WftuRAMU6NBGWGVpEIbLvYol42gpUN9jzAUrTXv1YCe7AXskElK7Lmn5f
         JgrgAFxipEmxlf7DvKU3FcIN3V3zjcamancmVoneRBS4bjUs6h8x3BJbOWz7VHvcR0LE
         Mqsg==
X-Gm-Message-State: AOAM5314bWcCDTZfLy2t00H7mrS0iRQAUDU3HTPT84n5Up8w9frUbzjE
        PXWQGnQPnOQYdLpDy0M6bQ==
X-Google-Smtp-Source: ABdhPJyVSoPfOlG3bABMGNUkllimA8tjCoYiWHbAbImE0Mv1LkkBB12zo19HHkTpIqYjKjTEECrEKQ==
X-Received: by 2002:a9d:4696:: with SMTP id z22mr10532837ote.293.1633371227643;
        Mon, 04 Oct 2021 11:13:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b23sm2467983oie.29.2021.10.04.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:13:47 -0700 (PDT)
Received: (nullmailer pid 1588870 invoked by uid 1000);
        Mon, 04 Oct 2021 18:13:46 -0000
Date:   Mon, 4 Oct 2021 13:13:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, maz@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, catalin.marinas@arm.com,
        rdunlap@infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] of, numa: Fetch empty NUMA node ID from distance
 map
Message-ID: <YVtEWnahMZcysdTg@robh.at.kernel.org>
References: <20210927064119.127285-1-gshan@redhat.com>
 <20210927064119.127285-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064119.127285-3-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 27 Sep 2021 14:41:19 +0800, Gavin Shan wrote:
> There is no device node for the empty NUMA node. However, the
> corresponding NUMA node ID and distance map is still valid in
> "numa-distance-map-v1" compatible device node.
> 
> This fetches the NUMA node ID and distance map for these empty
> NUMA node from "numa-distance-map-v1" compatible device node.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/of/of_numa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
