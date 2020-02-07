Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81515564C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBGLDo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 06:03:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726890AbgBGLDo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 06:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581073423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNlJpW3vAE5xzQwD1KkTA57bLeXUibHLesB2/sGPMLY=;
        b=M5LOVOOrDodExE6mzwoRhwJt380gxmifDNhweLltbl4PKFs2kRS+EY8bTPq7umy0SBcQRw
        W874dBWBacWPOCSPyrUskhmWl9LA/Xr/O7tnCMUO9i91hQe4SNF0DZllQIbP//Gnu0y4nN
        VVuIDm0ZWxy+7/uUTG7N+7sT/IheHYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-zTomoKWCPR2rnfK2JHCMNQ-1; Fri, 07 Feb 2020 06:03:41 -0500
X-MC-Unique: zTomoKWCPR2rnfK2JHCMNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462791800D42;
        Fri,  7 Feb 2020 11:03:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BF9B89F04;
        Fri,  7 Feb 2020 11:03:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        ilias.apalodimas@linaro.org, daniel.kiper@oracle.com
References: <20200206140352.6300-1-ardb@kernel.org>
 <20200206140352.6300-2-ardb@kernel.org>
 <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <5972fdf8-6b35-483b-5c0c-01a53665e885@redhat.com>
Date:   Fri, 7 Feb 2020 12:03:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/06/20 19:26, Heinrich Schuchardt wrote:
> On 2/6/20 3:03 PM, Ard Biesheuvel wrote:

>> +=C2=A0=C2=A0=C2=A0 status =3D efi_bs_call(handle_protocol, handle, &l=
f2_proto_guid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void **)&lf2);
>> +=C2=A0=C2=A0=C2=A0 if (status !=3D EFI_SUCCESS)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>=20
> You require here that there is a handle exposing the device path
> protocol with the initrd specific device path. On the same handle the
> EFI_LOAD_FILE2_PROTOCOL must be installed which will load the initrd
> file when called with the same device path.
>=20
> An alternative implementation would simple loop over all instances of
> the EFI_LOAD_FILE2_PROTOCOL and try to load the initrd.

That's not a great idea IMO. EFI_LOAD_FILE2_PROTOCOL instances take
device-specific filenames / pathnames to load. If you pass any
particular pathname (e.g. "initrd" or "\\initrd") to random
EFI_LOAD_FILE2_PROTOCOL instance in the protocol database, there could
be undesired results / side effects. (It could cause network activity,
for example.)

Sticking with a VenMedia (i.e. GUID-ed) devpath is much safer; it
practically lets us define our own device-specific filename / pathname
space. (And in my other email, I suggested "use an empty devpath" for
device-specific pathname, because that's the simplest, it looks
spec-conformat, and it's safe, because our GUID makes the load attempt
unique already.)

I do agree with your question though: "Please, indicate which software
you expect to expose the initrd related EFI_LOAD_FILE2_PROTOCOL."

Thanks
Laszlo

