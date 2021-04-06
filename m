Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8312355967
	for <lists+linux-efi@lfdr.de>; Tue,  6 Apr 2021 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbhDFQmm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Apr 2021 12:42:42 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:63769 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346527AbhDFQmi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Apr 2021 12:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3115; q=dns/txt; s=iport;
  t=1617727351; x=1618936951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=50Y5J3ymEIV3Iw/tW/yMYxTzDSV1S32YCccq6b0npb0=;
  b=O+l2WdgJHdqjz7CRsbSw3rpMz4eEj6h8Kr20AQHywZ/aSW09LiIA36ew
   xeHaV3IcjhsdurAAHMLXWbWwqqyzraSJ+ABZR47PewZ/KTaECjElElR69
   wUJCycTZupqKgElo3zL6cVgC5yKXYISYjcHxXbrLJ+n4nUZ45xBjIB9c/
   A=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApIoZVqjAH57WgZJThgTPBhL7W3BQX6B13D?=
 =?us-ascii?q?Abvn1ZSRFFG/GwvcrGppsm/DXzjyscX2xltNCbIa+bQW7d85kd2/h1AZ6JWg?=
 =?us-ascii?q?76tGy0aLx45Yz5zDH6XwH4/OhR1aBvGpIObOHYJ158kMr8/U2EA88tqeP3kp?=
 =?us-ascii?q?yAqO/Cwx5WJz1CRLpn625CZzqzMkozfwVeAIp8KZz03LshmxOFWVA6Kvu2HW?=
 =?us-ascii?q?MEWe+rnaypqLvDbQQdDxAqrCmi5AnI1JfAHxKV3ggTXlp0qN9IzUH/nwP0/a?=
 =?us-ascii?q?mluf2goyW960bo859UlNH9o+EsOOWwjKEuRgnEu0KBeJlmH4aPpikyp/uirG?=
 =?us-ascii?q?w3icDWrw07Vv4DjU/5TyWSvQbn3RXm3XII7XLvoGXo+UfLkIjeWC8wDdZHiM?=
 =?us-ascii?q?ZiVibhr2AkvN16zctwrhuki6Y=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AKAABBjmxg/4sNJK1aGgEBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBARIBAQEBAgIBAQEBQIE+BQEBAQELAYIqgU0BOTGMZokuA5AMFop?=
 =?us-ascii?q?GgXwLAQEBDQEBNAQBAYEWAYM0AwICgXYCJTQJDgIDAQEMAQEFAQEBAgEGBHE?=
 =?us-ascii?q?ThV2GRAEBAQMBMgFGBQsLGC48GwYThVghq051gTSBAYgfgUQUDoEXAY1MJxy?=
 =?us-ascii?q?BSUKENT6KNwSBVRBigQ9NgWKROgaNUoEgmXWBFIMVgSabRzIQpGG4PgIEBgU?=
 =?us-ascii?q?CFoFUOoFZMxoIGxWDJFAZDo4rFo5HIQMvOAIGAQkBAQMJjUQBAQ?=
X-IronPort-AV: E=Sophos;i="5.82,310,1613433600"; 
   d="scan'208";a="857077664"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2021 16:42:26 +0000
Received: from zorba ([10.24.14.212])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 136GgOjZ008120
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Apr 2021 16:42:26 GMT
Date:   Tue, 6 Apr 2021 09:42:24 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>, ob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        xe-linux-external@cisco.com, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] drivers: firmware: efi: libstub: enable generic
 commandline
Message-ID: <20210406164224.GU2469518@zorba>
References: <41021d66db2ab427c14255d2a24bb4517c8b58fd.1617126961.git.danielwa@cisco.com>
 <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
 <72fbd293-1d83-a558-4d7a-141576371864@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72fbd293-1d83-a558-4d7a-141576371864@csgroup.eu>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.14.212, [10.24.14.212]
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 02, 2021 at 07:36:53PM +0200, Christophe Leroy wrote:
> 
> 
> Le 30/03/2021 à 19:57, Daniel Walker a écrit :
> > This adds code to handle the generic command line changes.
> > The efi code appears that it doesn't benefit as much from this design
> > as it could.
> > 
> > For example, if you had a prepend command line with "nokaslr" then
> > you might be helpful to re-enable it in the boot loader or dts,
> > but there appears to be no way to re-enable kaslr or some of the
> > other options.
> > 
> > Cc: xe-linux-external@cisco.com
> > Signed-off-by: Daniel Walker <danielwa@cisco.com>
> > ---
> >   .../firmware/efi/libstub/efi-stub-helper.c    | 35 +++++++++++++++++++
> >   drivers/firmware/efi/libstub/efi-stub.c       |  7 ++++
> >   drivers/firmware/efi/libstub/efistub.h        |  1 +
> >   drivers/firmware/efi/libstub/x86-stub.c       | 13 +++++--
> >   4 files changed, 54 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index aa8da0a49829..c155837cedc9 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/efi.h>
> >   #include <linux/kernel.h>
> >   #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > +#include <linux/cmdline.h>
> >   #include <asm/efi.h>
> >   #include <asm/setup.h>
> > @@ -172,6 +173,40 @@ int efi_printk(const char *fmt, ...)
> >   	return printed;
> >   }
> > +/**
> > + * efi_handle_cmdline() - handle adding in building parts of the command line
> > + * @cmdline:	kernel command line
> > + *
> > + * Add in the generic parts of the commandline and start the parsing of the
> > + * command line.
> > + *
> > + * Return:	status code
> > + */
> > +efi_status_t efi_handle_cmdline(char const *cmdline)
> > +{
> > +	efi_status_t status;
> > +
> > +	status = efi_parse_options(CMDLINE_PREPEND);
> > +	if (status != EFI_SUCCESS) {
> > +		efi_err("Failed to parse options\n");
> > +		return status;
> > +	}
> > +
> > +	status = efi_parse_options(IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ? "" : cmdline);
> > +	if (status != EFI_SUCCESS) {
> > +		efi_err("Failed to parse options\n");
> > +		return status;
> > +	}
> > +
> > +	status = efi_parse_options(CMDLINE_APPEND);
> > +	if (status != EFI_SUCCESS) {
> > +		efi_err("Failed to parse options\n");
> > +		return status;
> > +	}
> > +
> > +	return EFI_SUCCESS;
> > +}
> 
> I think we can refactor to first build the final command line, then call
> efi_parse_options() only once after that.
 
I tried this, like what you did in your v4 .. The issues are similar to the
prom_init.c problems. The environment is delicate and requires careful
programming to get it done correctly.

> The big advantage of GENERIC_CMDLINE should be to not address anymore
> CONFIG_CMDLINE_XXX options at all outside of linux/cmdline.h
 
I agree , but not I've found that it's not likely to get this all changed in a
single series.

Daniel
