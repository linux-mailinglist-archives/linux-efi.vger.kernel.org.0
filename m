Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F612DD75
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 04:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgAADHd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 22:07:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbgAADHd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 22:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577848050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/p8BhtNCLSp9Ozj8HoauRIf/pLMwCeIl+KPkpdZZJNo=;
        b=gLaUh3XCIqLo3yh9Ixql96JGY/r7uWf8UgL7kGZP43FOUpnqva1Atahzl9O8d+pbDIcpWf
        y2kTd63jLBQNQ8YAownOdzQN4bAb8Vvesc1MB5TmXLM4vkSUi2O6OMh6Fo4WbCB7ngrBMB
        UyNNwCzxWdBiAkCVcqCUv6qtMV+qkUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-RR3Y863UMl6hQZ5CnRDGyg-1; Tue, 31 Dec 2019 22:07:27 -0500
X-MC-Unique: RR3Y863UMl6hQZ5CnRDGyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488518017DF;
        Wed,  1 Jan 2020 03:07:25 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C8D9383;
        Wed,  1 Jan 2020 03:07:20 +0000 (UTC)
Date:   Wed, 1 Jan 2020 11:07:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        sai.praneeth.prakhya@intel.com
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
Message-ID: <20200101030716.GB25936@dhcp-128-65.nay.redhat.com>
References: <20191226095510.20017-1-ardb@kernel.org>
 <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20200101030339.GA8856@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101030339.GA8856@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mistakenly dropped cc list, add again.
On 01/01/20 at 11:04am, Dave Young wrote:
> Hi Ard,
> On 12/31/19 at 12:13pm, Ard Biesheuvel wrote:
> > (adding Boris and Dave for the historical perspective)
> > 
> > On Thu, 26 Dec 2019 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > We carry a quirk in the x86 EFI code to switch back to an older
> > > method of mapping the EFI runtime services memory regions, because
> > > it was deemed risky at the time to implement a new method without
> > > providing a fallback to the old method in case problems arose.
> > >
> > > Such problems did arise, but they appear to be limited to SGI UV1
> > > machines, and so these are the only ones for which the fallback gets
> > > enabled automatically (via a DMI quirk). The fallback can be enabled
> > > manually as well, by passing efi=old_map, but there is very little
> > > evidence that suggests that this is something that is being relied
> > > upon in the field.
> > >
> > > Given that UV1 support is not enabled by default by the distros
> > > (Ubuntu, Fedora), there is no point in carrying this fallback code
> > > all the time if there are no other users. So let's refactor it a bit
> > > to make it depend on CONFIG_X86_UV, and remove the ability to enable
> > > it by hand.
> > >
> > > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > > Cc: Mike Travis <mike.travis@hpe.com>
> > > Cc: Hedi Berriche <hedi.berriche@hpe.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Boris, since you were the one that added efi=old_map: do you know of
> > any cases beyond SGI UV1 where it was actually needed? There is some
> > mention of using it to work around transient breakage on 32-bit caused
> > by your original changes, but other than that, Google doesn't seem to
> > know about any cases where efi=old_map is being used to deal with
> > actual firmware quirks.
> > 
> > As a followup to this change, I'd like to move the old memmap handling
> > into the UV1 support code, so it is omitted unless UV support is
> > compiled it, and so it can be retired with the rest of it once that
> > time comes.
> > 
> 
> I also only know about the SGI UV1 quirk, and I'm not sure about
> if this affects some 32bit user, otherwise it should be a good idea
> As for the 32bit I remember Sai previously did use old_map for kexecing.
> Added Sai in cc for thoughts.
> 
> Thanks
> Dave

