Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3F17A36E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCEKwL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 05:52:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbgCEKwL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 05:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583405530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UI+jv9WRtSfSOrEtwCJt1VuJ+panaiTzk05DWwgj8hE=;
        b=HRknIKDpghL6caqd+YJ0DLe0hJgHgNCsRMPR9rPLo+r0K/XyWhtcCPQY4p4/StEaGSYxWU
        jlWDJqVPRf/Lsrsr/3EGz/pU7PTZHqSPRy2ConhZGR0zg/fNT8oeSKpXcqLkMFl29JtJX8
        ZBVtJXvJjfKryM8LXvcQ8yC/Apkr6J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Ix9rltTnOy6V2Odi6gbcew-1; Thu, 05 Mar 2020 05:52:05 -0500
X-MC-Unique: Ix9rltTnOy6V2Odi6gbcew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE67800D50;
        Thu,  5 Mar 2020 10:52:04 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E455C219;
        Thu,  5 Mar 2020 10:52:04 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3363D1809563;
        Thu,  5 Mar 2020 10:52:04 +0000 (UTC)
Date:   Thu, 5 Mar 2020 05:52:04 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, joeyli <jlee@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <911968708.13281322.1583405524154.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAKv+Gu_n8MhgRFw-BUFgN1UUfTh1R6wsCNxKRA9QrQK74z6g7g@mail.gmail.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com> <20200305084041.24053-1-vdronov@redhat.com> <20200305084041.24053-2-vdronov@redhat.com> <CAKv+Gu_n8MhgRFw-BUFgN1UUfTh1R6wsCNxKRA9QrQK74z6g7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] efi: fix a race and a buffer overflow while
 reading efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.231, 10.4.195.11]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: ZwtG1mjZkaktWXHopN/M4SFWBKQyCQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Ard!

> > Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> > Link:
> > https://lore.kernel.org/linux-efi/20200303085528.27658-1-vdronov@redhat.com/T/#u
> 
> For the future, please don't add these links. This one points to the
> old version of the patch, not to this one. It will be added by the
> tooling once the patch gets picked up.

Aha. I was under an impression Links: are added manually by authors. My intention
here was to point at the root message of the whole discussion, not at the patch.

Anyway, thank you for the review and for bearing with me!

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

