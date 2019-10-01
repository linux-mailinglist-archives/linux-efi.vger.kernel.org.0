Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5BC3FA0
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfJASQu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 14:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfJASQu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Oct 2019 14:16:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCA420815;
        Tue,  1 Oct 2019 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569953807;
        bh=URWEvpqEPZZw2zcAevFFbA8yQME/4wiIjpDJ7FcpsdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJsPkZ+jZl2+AUEnqAq6lSM/s8DyCVx6LUJMP+/Np0MkQAeL71jL5gsa5Mn7Q86a2
         uTfBx8fqyWt1NnSsbz8Kwv6F8m2+9WsLXM83IUJBBRUrhImavvhgzh4dYXvOi1oB7U
         MuE4gbxlIECr316C0KJCDmkRDv5t+hqeuqfKZ1kU=
Date:   Tue, 1 Oct 2019 20:16:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] sysfs: add BIN_ATTR_WO() macro
Message-ID: <20191001181601.GA3705194@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826140131.GA15270@kroah.com>
 <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
 <20190826150153.GD18418@kroah.com>
 <7546990b-8060-9451-129a-19aaa856d2e1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7546990b-8060-9451-129a-19aaa856d2e1@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 01, 2019 at 02:08:53PM -0400, Nayna wrote:
> Hi Greg,
> 
> 
> On 08/26/2019 11:01 AM, Greg Kroah-Hartman wrote:
> > This variant was missing from sysfs.h, I guess no one noticed it before.
> > 
> > Turns out the powerpc secure variable code can use it, so add it to the
> > tree for it, and potentially others to take advantage of, instead of
> > open-coding it.
> > 
> > Reported-by: Nayna Jain <nayna@linux.ibm.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> > I'll queue this up to my tree for 5.4-rc1, but if you want to take this
> > in your tree earlier, feel free to do so.
> > 
> >   include/linux/sysfs.h | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > index 965236795750..5420817ed317 100644
> > --- a/include/linux/sysfs.h
> > +++ b/include/linux/sysfs.h
> > @@ -196,6 +196,12 @@ struct bin_attribute {
> >   	.size	= _size,						\
> >   }
> > +#define __BIN_ATTR_WO(_name) {						\
> > +	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
> > +	.store	= _name##_store,					\
> > +	.size	= _size,						\
> > +}
> > +
> >   #define __BIN_ATTR_RW(_name, _size)					\
> >   	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
> > @@ -208,6 +214,9 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
> >   #define BIN_ATTR_RO(_name, _size)					\
> >   struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
> > +#define BIN_ATTR_WO(_name, _size)					\
> > +struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
> > +
> >   #define BIN_ATTR_RW(_name, _size)					\
> >   struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
> 
> I am sorry. I didn't notice it via inspection but there is a bug in this
> macro. When I actually try using it, compilation fails. Here's a likely
> patch:
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 5420817ed317..fa7ee503fb76 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -196,9 +196,9 @@ struct bin_attribute {
>         .size   = _size,                                                \
>  }
> -#define __BIN_ATTR_WO(_name) {                                         \
> +#define __BIN_ATTR_WO(_name, _size) {                                  \
>         .attr   = { .name = __stringify(_name), .mode = 0200 },         \
> -       .store  = _name##_store,                                        \
> +       .write  = _name##_write,                                        \
>         .size   = _size,                                                \
>  }
> 

Heh, good catch.  Can you send a real patch for this that I can apply to
give you the proper credit for finding and fixing this?

thanks,

greg k-h
