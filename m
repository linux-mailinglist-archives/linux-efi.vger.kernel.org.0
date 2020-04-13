Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719441A678A
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgDMOHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 10:07:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60249 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730336AbgDMOHf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 10:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586786855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhNF3hI0xae/6/dg2QNRSGwFQztJmmvyxBBDiwMMhPM=;
        b=Vcuqo/ZgOmKVkPUv3K8vnQ+/aPHXiXyLHOQley86Pr0zLcB/ozpw/EPCz/J03AyXT9ulM1
        wAsM73ivIm+JEAAINnZS0Fec2eTQDIzNMVpgJIxnLyuoOpWiHivrGqbNqHJMuXzjz5F8fq
        3SUuxfipNJM9sxjv4igxRgvJzJOFTW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-b9q1jI89PgqqV41xqp8qrw-1; Mon, 13 Apr 2020 10:07:31 -0400
X-MC-Unique: b9q1jI89PgqqV41xqp8qrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41F8801A02;
        Mon, 13 Apr 2020 14:07:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C30B60BE0;
        Mon, 13 Apr 2020 14:07:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     dhowells@redhat.com, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2936362.1586786844.1@warthog.procyon.org.uk>
Date:   Mon, 13 Apr 2020 15:07:24 +0100
Message-ID: <2936363.1586786844@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've been seeing the:

        exit_boot() failed!
        efi_main() failed!

thing.  This fixes it.

Tested-by: David Howells <dhowells@redhat.com>

