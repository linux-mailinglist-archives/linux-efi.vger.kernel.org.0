Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADA549C523
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiAZIUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 03:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiAZIUR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 03:20:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37EC06161C;
        Wed, 26 Jan 2022 00:20:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4731EC052A;
        Wed, 26 Jan 2022 09:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643185210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BGWljlTr9Q5xPRGp4H5G0kng/4W1lTPQPYHkwyGS2kE=;
        b=gkOgIOP1drCqOCGgupEyHCHNgEIxSylkjZQRCAfAv5qhBPrNO8A5NmKzyE4qWBCxs0UgTJ
        EZ0T+iozkEO9VNHPbJat42XG/9daPWe2bmd9WMJMwuX+rIg51AMC+3VEi8e5FlDl6dbu6+
        lMlGW/vKw9InDnkm/afN1h87SGxDCiU=
Date:   Wed, 26 Jan 2022 09:20:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v5 0/2] EDAC/ghes: refactor memory error reporting to
 avoid code duplication
Message-ID: <YfEEN0ATgS+TakLV@zn.tnic>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220126081702.55167-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220126081702.55167-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 26, 2022 at 04:17:00PM +0800, Shuai Xue wrote:
> ghes_edac_report_mem_error() in ghes_edac.c is a Long Method and have
> Duplicated Code with cper_mem_err_location(), cper_dimm_err_location(), and
> cper_mem_err_type_str() in drivers/firmware/efi/cper.c. In addition, the
> cper_print_mem() in drivers/firmware/efi/cper.c only reports the error
> status and misses its description.

Dude, what about

	wait for a week or until the patchset has been fully reviewed

don't you understand?!

Please let me know what about the review process is not clear to you so
that we can document it better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
