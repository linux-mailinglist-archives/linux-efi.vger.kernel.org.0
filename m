Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE5177414
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgCCKZC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 05:25:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728480AbgCCKZC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 05:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583231101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9OskcRkJBB13zwLLGMfs2S2+SpY5k0BUryUkH7intc=;
        b=iVaKgjE031bDkJ/OWL6R2zxwibNYiRh5yCoJxUB188sVJAdOrIuutpOgGv0QAmzYs/dWIC
        IUXMjY8eO9tfaofpWag1dhismXj5aEulD37azdRPCX4kYy5QuP2SEfUu9bsVzy21Q8xnoT
        JaIigerU1LEruO047hSAC755O/IdnmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-Mq5NpSpDOvCPhq4vNA4ahw-1; Tue, 03 Mar 2020 05:24:59 -0500
X-MC-Unique: Mq5NpSpDOvCPhq4vNA4ahw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A808D800D50;
        Tue,  3 Mar 2020 10:24:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CD0160BF3;
        Tue,  3 Mar 2020 10:24:58 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 90B6686A00;
        Tue,  3 Mar 2020 10:24:58 +0000 (UTC)
Date:   Tue, 3 Mar 2020 05:24:58 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <358842423.12639861.1583231098544.JavaMail.zimbra@redhat.com>
In-Reply-To: <1980156503.12639063.1583230452485.JavaMail.zimbra@redhat.com>
References: <20200303085528.27658-1-vdronov@redhat.com> <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com> <1980156503.12639063.1583230452485.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.56, 10.4.195.30]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: a9pXAtMcyqvelpyZViw1cEjneZdMYYgMv25R
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Ard, all,

> > Wouldn't it be easier to pass a var_data_size stack variable into
> > efivar_entry_get(), and only update the value in 'var' if it is <=
> > 1024?
> > 
> 
> I was thinking about this approach, but this way we still do not protect
> var from a concurrent access. For example, efivar_data_read() can race
> with itself:

Oh, indeed, this race is not possible the way you sugget with a var_data_size
stack variable. Unfortunately, AFAIU, the read/write race stays:
 
> ... efivar read functions still can race with the write function
> efivar_store_raw(). Surely, the race window is much smaller but it is there.
> I strongly believe we need to protect all data accesses here with a lock.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

