Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E05108876
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2019 06:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYFwN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Nov 2019 00:52:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYFwN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Nov 2019 00:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574661131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYYoUTw7mDYpUvKp3ik9S4wEbrWP4Kv9LggG9gp+XVM=;
        b=M1glme9S0YSO4EOsrMt7V5JLczAEUcOMgtKwd1eGRI8SBDXBmzrn6Lq0TTIxLcXHMKzuDY
        Y9nNMsGu9CSJY7swuvPCUJtEXEbbPjxh55b3E+7VyKpybNYzjt8JzN+bVcgBPeHP1SZr1n
        X4/pxnkPXvzwGE7aSzd291ECOfg1LpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-jmBvyL4WMY6xN-JIXAZlmA-1; Mon, 25 Nov 2019 00:52:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB837477;
        Mon, 25 Nov 2019 05:52:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 606015D9CA;
        Mon, 25 Nov 2019 05:52:04 +0000 (UTC)
Date:   Mon, 25 Nov 2019 13:52:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Michael Weiser <michael@weiser.dinsnail.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
MIME-Version: 1.0
In-Reply-To: <20191122210702.GE32104@weiser.dinsnail.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jmBvyL4WMY6xN-JIXAZlmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/22/19 at 10:07pm, Michael Weiser wrote:
> Hi Eric,
>=20
> On Fri, Nov 22, 2019 at 02:00:22PM -0600, Eric W. Biederman wrote:
>=20
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > (The image is rather large at 18MiB as it has a built-in initrd.)
> > When did x86_64 get support for ARCH_KEEP_MEMBLOCK?  I can't find it
> > anywhere.
>=20
> No, is hasn't. I temporarily hacked that in to see if it'd change
> anything and it did. Sorry to not be more clear about that.
>=20
> > Fundamentally when deciding where to place a new kernel kexec (either
> > user space or the in kernel kexec_file implementation) needs to be able
> > to ask the question which memory ares are reserved.
> > What the buddy
> > allocator does is unimportant as kexec copies memory from all over
> > the place and places it in the destined memory addresses at the
> > time of the kexec operation.
>=20
> > So my question is why doesn't the ESRT reservation wind up in
> > /proc/iomem?
>=20
> My guess is that the focus was that some EFI structures need to be kept
> around accross the life cycle of *one* running kernel and
> memblock_reserve() was enough for that. Marking them so they survive
> kexecing another kernel might just never have cropped up thus far. Ard
> or Matt would know.

Can you check your un-reserved memory, if your memory falls into EFI
BOOT* then in X86 you can use something like below if it is not covered:

void __init efi_esrt_init(void)
{
...
=09pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
=09if (md.type =3D=3D EFI_BOOT_SERVICES_DATA)
=09=09efi_mem_reserve(esrt_data, esrt_data_size);
...
}

Unfortunately I noticed there are different requirements/ways for
different types of "reserved" memory.  But that is another topic..

Thanks
Dave=20

