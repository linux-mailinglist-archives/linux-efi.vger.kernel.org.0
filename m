Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8873C622705
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKIJbO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKIJbK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 04:31:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADF222BD;
        Wed,  9 Nov 2022 01:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97516198B;
        Wed,  9 Nov 2022 09:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11366C43146;
        Wed,  9 Nov 2022 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667986267;
        bh=K+1dftlduiW1W4qx5Av6A0p78GIBItL51LGqPvh8qpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQeYpWH9ofRyOplyGNNYtl7hiFlW7c09YW8quzsEwWn0C48mrdbqgf8kG7J1rHiYv
         gFnjH2c3pOHwnyrvqENKkJUc/05xsXG3oaZHA+DvMOj+FAANpVVuLaY097HhHigKBz
         ZyCdjAG0W1kRdBT9OErKhZDqvDis/moUfI/wjv7tlD2Cit+Vvvxge4QsnaJozzweIh
         nJYMQI3sRB/YDYAUJraEKziq+KYeaV2WT9E1a9ANoMW+cPIaH+bpziHnUB0v3Ew23o
         k2pnd2eKGFY7Fg6uGQ5XBGpmBvYx2/r5FcQfFcymMI9FqU1dNUd2s3z/wPiNQncRyh
         c5Bv6yQr9CwjQ==
Received: by mail-lj1-f177.google.com with SMTP id u11so24857822ljk.6;
        Wed, 09 Nov 2022 01:31:06 -0800 (PST)
X-Gm-Message-State: ACrzQf2910uTwjEGEAN5q42Yw9YE6XjzRaDaXs16e/E7GzpjGG9JnOgp
        EzjIVMgByIy8hugjqN0hbmTyUiGRhJIpuPu7DGg=
X-Google-Smtp-Source: AMsMyM7q2WdHrQWcIS0IKO/T2ThqKDp5nMzHb1fOCs2PcB7duk1mEdG8UdWhGr5zoWGfrlQWCC9JY738gn2YOyosfs4=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr21819820lji.291.1667986265037; Wed, 09
 Nov 2022 01:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 10:30:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF8vpvM_MysVO7NcWy5YgXQvcYcQmKNh9aV6eyeR8jwKw@mail.gmail.com>
Message-ID: <CAMj1kXF8vpvM_MysVO7NcWy5YgXQvcYcQmKNh9aV6eyeR8jwKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 22:10, Smita Koralahalli
<Smita.KoralahalliChannabasappa@amd.com> wrote:
>
> This series adds decoding for the CXL Protocol Errors Common Platform
> Error Record.
>
> Smita Koralahalli (2):
>   efi/cper, cxl: Decode CXL Protocol Error Section
>   efi/cper, cxl: Decode CXL Error Log
>

I've queued these up now (with Jonathan's ack)


>  drivers/firmware/efi/Makefile   |   2 +-
>  drivers/firmware/efi/cper.c     |   9 ++
>  drivers/firmware/efi/cper_cxl.c | 179 ++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h |  66 ++++++++++++
>  include/linux/cxl_err.h         |  22 ++++
>  5 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/cper_cxl.c
>  create mode 100644 drivers/firmware/efi/cper_cxl.h
>  create mode 100644 include/linux/cxl_err.h
>
> --
> 2.17.1
>
