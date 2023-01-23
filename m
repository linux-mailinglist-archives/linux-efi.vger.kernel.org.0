Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE246776E6
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 09:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAWI7T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 03:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAWI7T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 03:59:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632D5EB58;
        Mon, 23 Jan 2023 00:59:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DD760DED;
        Mon, 23 Jan 2023 08:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFF8C433D2;
        Mon, 23 Jan 2023 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674464357;
        bh=+0L5o0QQnbJOjBIVjk7k2zPu/WYY7Ppxr1/oLKHl7Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DY5cfrhFSYtYUMfYZYovvmawsDzlkKxEOrae/qPhvHYia/lRyuIkUbyQGr6h30LYy
         cp0j/1wxoyNZW3FV5XqeguPSE/GJrM1qmKqfGvhf4zzILxuK30K8SYMqw7dsqOW/fe
         SGbaOjHxAuJmPqFuabG53ZnXpbxFCmVhMI3zKVVK3mYblNRDvlNSRv9NOavof3c2XM
         DqQETzfKV0+tArS1pNP68xGyr3ivadQCvXD1ZF09xOdVNmndiDiBkKvrTiZeph8NMu
         xyiaLn6MCT//La60SUQzkWBjVVQk3d5RAv0My7C34gRWyEwu0aDf5CqHp/ClZ9xdDu
         xnRnC//lu395A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJsfa-0008AL-KK; Mon, 23 Jan 2023 09:59:14 +0100
Date:   Mon, 23 Jan 2023 09:59:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efi: drop obsolete efivars sysfs documentation
Message-ID: <Y85MYpfHOsFJ8GF6@hovoldconsulting.com>
References: <20230123081905.27283-1-johan+linaro@kernel.org>
 <CAMj1kXGPo4-igHOseNhvoBuS0O2YLd+e=cqD8RJJYSgP0zTi0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGPo4-igHOseNhvoBuS0O2YLd+e=cqD8RJJYSgP0zTi0Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 23, 2023 at 09:39:41AM +0100, Ard Biesheuvel wrote:
> On Mon, 23 Jan 2023 at 09:19, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The efivars sysfs interface was removed by commit 0f5b2c69a4cb ("efi:
> > vars: Remove deprecated 'efivars' sysfs interface").
> >
> > Remove also the corresponding sysfs ABI documentation.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >
> > Changes in v2
> >  - drop reference in gsmi sysfs documentation
> >  - drop reference in efivarfs.rst (kernel test robot)
> >
> 
> Ugh. So there is a remaining implementation of that interface. That is
> a bit disappointing, tbh.

No, you removed the implementation in the commit mentioned above. The
Google SMI driver only provides a efivars "backend" but the interface
was shared. The driver continues to work with efivarfs.

> So for now, let's disregard this patch, and I will check internally
> whether or not that sysfs gsmi interface is actually used. If it is,
> the docs should be kept but updated to clarify that it only describes
> gsmi sysfs. Otherwise, we can drop the whole thing, including the gsmi
> sysfs pieces themselves.

So you'd need to bring back the sysfs implementation and make it Google
SMI specific if it's still needed by someone. I don't think we want to
do that if it can be avoided.

Johan
