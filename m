Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82361793D7
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgCDPpU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:45:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729573AbgCDPpU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 10:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583336719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCLVGTRxnbfjjeCTr0ddYoiLTCcPK4JAZKp83eU87BU=;
        b=C91w7saEiAB0r5r0KvNFiLsrJkTkxO1wFvcwGggRoFIqib8Dlzrm3uKu9qil4StYilTB1o
        j0sKS88/Gbw2k3ns8B7Zb5tGTtd0Ww9zV8FYlki94kAyRs5wPE1ZKFCAtPy2Nbf3dRnIYu
        MFzPp7vNJ+YAYy5Jzji0Jgw+H9YdR4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-ObxcWQTKPraYzzAA2DDGeQ-1; Wed, 04 Mar 2020 10:45:17 -0500
X-MC-Unique: ObxcWQTKPraYzzAA2DDGeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F847800053;
        Wed,  4 Mar 2020 15:45:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 437375DA2C;
        Wed,  4 Mar 2020 15:45:16 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 339A28174D;
        Wed,  4 Mar 2020 15:45:16 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:45:16 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <925307051.13073500.1583336716147.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
References: <20200303085528.27658-1-vdronov@redhat.com> <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.205, 10.4.195.6]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: dewbhvzFQPAb58gKxgYvGl/QeO33kQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Ard,

> Wouldn't it be easier to pass a var_data_size stack variable into
> efivar_entry_get(), and only update the value in 'var' if it is <=
> 1024?

I have prepared a v2 patch with an approach you suggest and will send it
out shortly. It indeed simpler and fixes only the overflow bug mentioned.

Could you, please, review it and if you like it, probably, accept it?
In case I've implemented your idea incorrectly, could you, please,
correct me?

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

