Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E586DF281
	for <lists+linux-efi@lfdr.de>; Wed, 12 Apr 2023 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDLLFD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Apr 2023 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDLLFC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Apr 2023 07:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562426A5F;
        Wed, 12 Apr 2023 04:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2D463255;
        Wed, 12 Apr 2023 11:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B0C433D2;
        Wed, 12 Apr 2023 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681297500;
        bh=6ACRjS9taP0Br9NBMa4IZSxz0sG2bxUgpX3aEEydlck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CYtP8Nefz3ZqmENkeR/ZnuilUvGgCHOlQmRuWpB3u4mtCdfyHuYmwwnV7KIGK8gwI
         QHxDuqhZQYp8XvLHsPvD/XkcxMcWncb2Sk0NKUlp3le1o9/x86j5opJWi3v3i3XFPu
         9gn+S8NnTnha96eGlUDtDu6NDbuo2uam/ecmKEEOfoHGJrUHrAyLQg57rJ+Z6PD42D
         EMop7VqvMtgz6UpsOp17gt1H/byZCWRLVzflvRo1uE+BJsO6iUXL9JmdKMO6457CcI
         0Rsa3eP5w7SUGCvA9SLPBDVL6R6XIBvVH9LanQdB7hzce+PoxBrWBefA4sd5KBnEoB
         69nS6bi7FNi/A==
Received: by mail-lf1-f48.google.com with SMTP id e11so14114252lfc.10;
        Wed, 12 Apr 2023 04:05:00 -0700 (PDT)
X-Gm-Message-State: AAQBX9c60+JEgd5eIz/2ynP85TM92Yzu22P8moZD+mBwLuvCou9VLNPm
        FGb/TLcMm0h+FWodvmChL13CnjMlqZOb24yLm0g=
X-Google-Smtp-Source: AKy350b1aEyRr4j1G/tTTUEA9AcniJJkuDBi8PVJYpQ9n2aX6dsR7wyVmDFAUZWhwbZGG+bgquCRlsHoJc6fLeY9nok=
X-Received: by 2002:ac2:5312:0:b0:4ec:a23e:69c8 with SMTP id
 c18-20020ac25312000000b004eca23e69c8mr234992lfh.9.1681297498269; Wed, 12 Apr
 2023 04:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230411180302.2678736-1-terry.bowman@amd.com> <20230411180302.2678736-3-terry.bowman@amd.com>
In-Reply-To: <20230411180302.2678736-3-terry.bowman@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Apr 2023 13:04:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH38KnOsX+QffXi_UO3ZKXJMpB=VcSzJFeYBron=GTbdw@mail.gmail.com>
Message-ID: <CAMj1kXH38KnOsX+QffXi_UO3ZKXJMpB=VcSzJFeYBron=GTbdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by modules
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 11 Apr 2023 at 20:03, Terry Bowman <terry.bowman@amd.com> wrote:
>
> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
> logging. This is not currently possible if CXL is built as a loadable
> module because cper_print_aer() depends on cper_mem_err_unpack() which
> is not exported.
>
> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
> CXL and other loadable modules.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/cper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..ff15e12160ae 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
>
>  static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>         int len)
> --
> 2.34.1
>
