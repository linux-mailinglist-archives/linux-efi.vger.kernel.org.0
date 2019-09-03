Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABCA5FD0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Sep 2019 05:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfICDhI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Sep 2019 23:37:08 -0400
Received: from ozlabs.org ([203.11.71.1]:45387 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfICDhI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Sep 2019 23:37:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Mt1C3FNgz9sDB;
        Tue,  3 Sep 2019 13:37:03 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] sysfs: add BIN_ATTR_WO() macro
In-Reply-To: <20190826150153.GD18418@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com> <1566825818-9731-3-git-send-email-nayna@linux.ibm.com> <20190826140131.GA15270@kroah.com> <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com> <20190826150153.GD18418@kroah.com>
Date:   Tue, 03 Sep 2019 13:37:02 +1000
Message-ID: <87ef0yrqxt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> This variant was missing from sysfs.h, I guess no one noticed it before.
>
> Turns out the powerpc secure variable code can use it, so add it to the
> tree for it, and potentially others to take advantage of, instead of
> open-coding it.
>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> I'll queue this up to my tree for 5.4-rc1, but if you want to take this
> in your tree earlier, feel free to do so.

OK. This series is blocked on the firmware support going in, so at the
moment it might miss v5.4 anyway. So this going via your tree is no
problem.

If it does make it into v5.4 we can do a fixup patch to use the new
macro once everything's in Linus' tree.

cheers

> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 965236795750..5420817ed317 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -196,6 +196,12 @@ struct bin_attribute {
>  	.size	= _size,						\
>  }
>  
> +#define __BIN_ATTR_WO(_name) {						\
> +	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
> +	.store	= _name##_store,					\
> +	.size	= _size,						\
> +}
> +
>  #define __BIN_ATTR_RW(_name, _size)					\
>  	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
>  
> @@ -208,6 +214,9 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
>  #define BIN_ATTR_RO(_name, _size)					\
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
>  
> +#define BIN_ATTR_WO(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
> +
>  #define BIN_ATTR_RW(_name, _size)					\
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>  
> -- 
> 2.23.0
