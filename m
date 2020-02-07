Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18749155665
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGLJz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 06:09:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgBGLJz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 06:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581073794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCntgRDrXOkiD6uxO1AkQeRXwRIwbg4qjS/12HTChTM=;
        b=bBYKRJEQc7qRMeFHuO1GouMOJPyjwEA/aZZxEimOjP1cBf4nPxbRqWg1VPe3n31JrrQUpF
        Yom6SVANzY0YKTX1BPEg0bL1NaEeOtcKcN39AecXll1w6sW0CitzYx9S/2R14mEE1WfVXh
        gJTzMO5KTSbvsJalR20rOGRg6U6I8HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Z5R0xcXuMqK-E4vfKKJ61A-1; Fri, 07 Feb 2020 06:09:50 -0500
X-MC-Unique: Z5R0xcXuMqK-E4vfKKJ61A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5631005513;
        Fri,  7 Feb 2020 11:09:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF4A60BF7;
        Fri,  7 Feb 2020 11:09:46 +0000 (UTC)
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
References: <20200206140352.6300-1-ardb@kernel.org>
 <20200206140352.6300-2-ardb@kernel.org>
 <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de>
 <CAKv+Gu9Z24GeqrqKhPJN+aAu8crSKvT0ZBeFL=0ik=z2Sd1FmQ@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <ecc0febc-b964-5754-580f-7514427a068d@redhat.com>
Date:   Fri, 7 Feb 2020 12:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9Z24GeqrqKhPJN+aAu8crSKvT0ZBeFL=0ik=z2Sd1FmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/06/20 23:35, Ard Biesheuvel wrote:
> On Thu, 6 Feb 2020 at 18:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

>> When booting via GRUB it will be GRUB knowing which initrd to load.
>>
> 
> Exactly, which is why GRUB will implement this protocol. That way, it
> does not have to touch the DT at all, or create a bootparams struct
> from setup data and inspect the various flags about placement,
> alignment, preferred addresses, etc.
> 
>> Please, indicate which software you expect to expose the initrd related
>> EFI_LOAD_FILE2_PROTOCOL.
>>
> 
> The primary use case is GRUB and other intermediate loaders, since it
> would remove any need for these components to know any such details.
> My aim is to make the next architecture that gets added to GRUB for
> EFI boot 100% generic.

Understood, thanks. It sounds plausible to me.

Laszlo

