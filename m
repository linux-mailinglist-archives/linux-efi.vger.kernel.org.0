Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A909231978
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jul 2020 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgG2GWT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 02:22:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:53878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2GWT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Jul 2020 02:22:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D71AAB3D;
        Wed, 29 Jul 2020 06:22:28 +0000 (UTC)
Date:   Wed, 29 Jul 2020 08:22:17 +0200
Message-ID: <s5ha6zig7s6.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/19] firmware: Add request_partial_firmware_into_buf()
In-Reply-To: <20200729011739.GL4332@42.do-not-panic.com>
References: <20200724213640.389191-1-keescook@chromium.org>
        <20200724213640.389191-19-keescook@chromium.org>
        <20200729011739.GL4332@42.do-not-panic.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Jul 2020 03:17:39 +0200,
Luis Chamberlain wrote:
> 
> Long ago Takashi had some points about this strategy breaking
> compressed file use. Was that considered?

As long as I read the patch, it tries to skip both the compressed and
the fallback loading when FW_OPT_PARTIAL is set, which is good.

However...

> > @@ -771,18 +805,20 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> >  	}
> >  
> >  	ret = _request_firmware_prepare(&fw, name, device, buf, size,
> > -					opt_flags);
> > +					offset, opt_flags);
> >  	if (ret <= 0) /* error or already assigned */
> >  		goto out;
> >  
> >  	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
> > -#ifdef CONFIG_FW_LOADER_COMPRESS
> > -	if (ret == -ENOENT)
> > +
> > +	/* Only full reads can support decompression, platform, and sysfs. */
> > +	if (!(opt_flags & FW_OPT_PARTIAL))
> > +		nondirect = true;
> > +
> > +	if (ret == -ENOENT && nondirect)
> >  		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
> >  						 fw_decompress_xz);
> > -#endif

... by dropping this ifdef, the fw loader would try to access *.xz
file unnecessarily even if CONFIG_FW_LOADER_COMPRESS is disabled.


thanks,

Takashi
