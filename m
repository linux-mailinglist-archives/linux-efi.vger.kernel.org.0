Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B246D15D
	for <lists+linux-efi@lfdr.de>; Wed,  8 Dec 2021 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhLHKxt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Dec 2021 05:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLHKxs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Dec 2021 05:53:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9EEC061746;
        Wed,  8 Dec 2021 02:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A1EB82089;
        Wed,  8 Dec 2021 10:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5880EC00446;
        Wed,  8 Dec 2021 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638960614;
        bh=+nI62eh7Zk9rq1LC16W1ZYAytYZC0sTX786aEudokNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlY3afEKTOja6hjuwYrUDZEWksuICk31i3To7Kc6iGw1Wcl67/LXD4qZJKGTroUwx
         SfQRi33BBe1dX2FXI1p52/hZCYs0mQYiODJdmUqkgF+KXgFTDlTKsSr3wBuEczmhlb
         qT0MVngN7jdWAFk3JPDzQe8UE0C5jZ4mjeGXC4jWnQvhdwdSoBcIQLXemukdhNlAtB
         WQUED+wvSC/9Pp8VtgPkGbQGJXvlDLADyc35l92qEI3LCEuky0Z7B/VTs15GkaiAg9
         kuzxRoQDO57m2cfV2PqRljXcb0so38CSNc4XaboEb3TkREMa7S8TgUllmv/HSUH9Mm
         OaJTyUWYuWW9Q==
Date:   Wed, 8 Dec 2021 11:50:07 +0100
From:   Robert Richter <rric@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH 2/2] ghes_edac: refactor error status fields decoding
Message-ID: <YbCN3yXUVsCgP+x7@rric.localdomain>
References: <20211207031905.61906-2-xueshuai@linux.alibaba.com>
 <20211207031905.61906-3-xueshuai@linux.alibaba.com>
 <Ya9JxfyXYYNtLoSf@rric.localdomain>
 <662eff5c-8c53-8035-cae0-99448734406c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662eff5c-8c53-8035-cae0-99448734406c@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.12.21 21:20:25, Shuai Xue wrote:

> >> --- a/include/linux/cper.h
> >> +++ b/include/linux/cper.h
> >> @@ -568,7 +568,8 @@ void cper_print_proc_arm(const char *pfx,
> >>  			 const struct cper_sec_proc_arm *proc);
> >>  void cper_print_proc_ia(const char *pfx,
> >>  			const struct cper_sec_proc_ia *proc);
> >> -int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
> >> -int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
> >> +int cper_mem_err_location(const struct cper_mem_err_compact *mem, char *msg);
> >> +int cper_dimm_err_location(const struct cper_mem_err_compact *mem, char *msg);
> > 
> > Do we really need that 'const' here?
> I think we do. It is read only and should not be modified in these functions,
> just as cper_print_proc_arm' style.

Even if it is used read-only I don't see a real need for const here.
So let's change this only if there is a reason such as avoiding
unnecessary casts.

> >> +const char *cper_mem_err_status_str(u64 status);
> > 
> > The function i/f is different compared to the others, though the
> > purpose is the same. Let's use same style:
> > 
> >  int cper_mem_err_status(const struct cper_mem_err_compact *mem, char *msg);
> Sorry, I don't catch it. cper_mem_err_status_str() decodes the error status and return
> a string, the same style as cper_severity_str and cper_mem_err_type_str do. May
> we need to move the declaration ahead with cper_severity_str?

Right, move it after cper_mem_err_type_str(). Looks good then.

Thanks,

-Robert
