Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50009350635
	for <lists+linux-efi@lfdr.de>; Wed, 31 Mar 2021 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhCaSWS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Mar 2021 14:22:18 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:10898 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhCaSVt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 Mar 2021 14:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3897; q=dns/txt; s=iport;
  t=1617214909; x=1618424509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8lk/7k5wkWXyrsD9aMvvKA4Te42fmRyrTbrrcgdlHo=;
  b=DnwepRTBGTTg24CaUb1dkzKANaZ8ihb3zX7JblLYcXe7Y55pWrN6kCb4
   DmUf//umsjebKxeOS6NhEHAY+C9yUHGm4LrfFqrEh+KI9cFYnhZLXpyDY
   jAAgCylIbKXepZ81jHMSi/+or58WV31ZOux8D3u2NSYJzQT8jG+hl5pU3
   M=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWKfFL6jA4QpEqfo1THc148MX4HBQX4F13D?=
 =?us-ascii?q?Abvn1ZSRFFG/GwvcrGppsm/DXzjyscX2xltNCbIa+bQW7d85kd2/h1AZ6JWg?=
 =?us-ascii?q?76tGy0aLxz9IeK+UyDJwTS/vNQvJ0LT4FQE9v1ZGIWse/b502CH88k0J279s?=
 =?us-ascii?q?mT9IPj5lNMaS0vVK169Qd+DW+gYy5LbS1LH4AwGpbZxucvnVudUE8aZMi6GX?=
 =?us-ascii?q?UJNtKrz7b2vanrbhIcCxks5BPmt1OVwYTnGBuV1Ap2aV1y6IolmFKoryXJoo?=
 =?us-ascii?q?2+rvf+8RPHzmnV9ZgTosf508BOHtbksLlzFhzcziC1eY9mR7qO+Bcyre3H0i?=
 =?us-ascii?q?dSrPD85zE9Is9093TdOluQnCKo8Qzh3DEygkWSr2OlvQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AkAABzvGRg/5FdJa1aGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBPAYBAQELAYIqgUwBOTGMZYkuA5AIFopFgXwLAQE?=
 =?us-ascii?q?BDQEBNAQBAYRQAoF7AiU0CQ4CAwEBDAEBBQEBAQIBBgRxhW6GRQEFOj8QCxg?=
 =?us-ascii?q?uPBsGE4V5qnd1gTSJCIFEFA6BFwGNSSYcgUlChC4+ijYEgkAGAXsUgmWQfwa?=
 =?us-ascii?q?CdopQgSCZb4EUgxGBI5s5MRCkSLgbAgQGBQIWgVQ6gVkzGggbFYMkUBkNjis?=
 =?us-ascii?q?WjkchAy84AgYKAQEDCY8JAQE?=
X-IronPort-AV: E=Sophos;i="5.81,293,1610409600"; 
   d="scan'208";a="609843726"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Mar 2021 18:21:48 +0000
Received: from zorba ([10.24.8.227])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 12VILjhE015710
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Mar 2021 18:21:47 GMT
Date:   Wed, 31 Mar 2021 11:21:45 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, xe-linux-external@cisco.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] drivers: firmware: efi: libstub: enable generic
 commandline
Message-ID: <20210331182145.GJ2469518@zorba>
References: <41021d66db2ab427c14255d2a24bb4517c8b58fd.1617126961.git.danielwa@cisco.com>
 <e5d98d566c38d6f8516b8d9d1fd603ec1f131037.1617126961.git.danielwa@cisco.com>
 <CAMj1kXG_rRLU2Hp_GaZyayxx6J+HaWyPHPmE-hEZawuxzZ4JXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG_rRLU2Hp_GaZyayxx6J+HaWyPHPmE-hEZawuxzZ4JXw@mail.gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.8.227, [10.24.8.227]
X-Outbound-Node: rcdn-core-9.cisco.com
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 31, 2021 at 06:10:08PM +0200, Ard Biesheuvel wrote:
> (+ Arvind)
> 
> On Tue, 30 Mar 2021 at 19:57, Daniel Walker <danielwa@cisco.com> wrote:
> >
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
> >  .../firmware/efi/libstub/efi-stub-helper.c    | 35 +++++++++++++++++++
> >  drivers/firmware/efi/libstub/efi-stub.c       |  7 ++++
> >  drivers/firmware/efi/libstub/efistub.h        |  1 +
> >  drivers/firmware/efi/libstub/x86-stub.c       | 13 +++++--
> >  4 files changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index aa8da0a49829..c155837cedc9 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/efi.h>
> >  #include <linux/kernel.h>
> >  #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > +#include <linux/cmdline.h>
> >  #include <asm/efi.h>
> >  #include <asm/setup.h>
> >
> > @@ -172,6 +173,40 @@ int efi_printk(const char *fmt, ...)
> >         return printed;
> >  }
> >
> > +/**
> > + * efi_handle_cmdline() - handle adding in building parts of the command line
> > + * @cmdline:   kernel command line
> > + *
> > + * Add in the generic parts of the commandline and start the parsing of the
> > + * command line.
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_handle_cmdline(char const *cmdline)
> > +{
> > +       efi_status_t status;
> > +
> > +       status = efi_parse_options(CMDLINE_PREPEND);
> > +       if (status != EFI_SUCCESS) {
> > +               efi_err("Failed to parse options\n");
> > +               return status;
> > +       }
> 
> Even though I am not a fan of the 'success handling' pattern,
> duplicating the exact same error handling three times is not great
> either. Could we reuse more of the code here?

How about

efi_status_t status = 0;

status |= efi_parse_options(CMDLINE_PREPEND);

then error checking once ?

> > +
> > +       status = efi_parse_options(IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ? "" : cmdline);
> 
> What is the point of calling efi_parse_options() with an empty string?
 
I could change it to if ((IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) ?

> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -172,6 +172,12 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
> >                 goto fail;
> >         }
> >
> > +#ifdef CONFIG_GENERIC_CMDLINE
> > +       status = efi_handle_cmdline(cmdline_ptr);
> > +       if (status != EFI_SUCCESS) {
> > +               goto fail_free_cmdline;
> > +       }
> > +#else
> >         if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> >             IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> 
> Does this mean CONFIG_GENERIC_CMDLINE does not replace CMDLINE_EXTEND
> / CMDLINE_FORCE etc, but introduces yet another variant on top of
> those?
> 
> That does not seem like an improvement to me. I think it is great that
> you are cleaning this up, but only if it means we can get rid of the
> old implementation.
 
It does replace extend and force. I was under the impression this code was
shared between arm64 and arm32. If that's not the case I can delete the extend
and force section. I haven't submitted a conversion for arm32 yet.

Daniel
