Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1507A17A187
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCEIlq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:41:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbgCEIlp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 03:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583397704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuWQ+iLEiNR6MjU69NtgSJHIMX21Xib1ZaETC6m+QbM=;
        b=ZIajPMYzFl3kaMofv7zqIfp8eeHCMGf+LimN1j7Ao4WBwy1IYRNpOJpuc8pzPvtoVo00xd
        3nhtxEikAEm+ma69eN10VBsSsBFwIjo4z9bJe5u63XdawDhh5jVxGAnkXtjsbJM0VXw37U
        KpEFetB1aag2PkROIJabjEpXJs3U6Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-FyDKhKtVOMup3-dZA3TmHA-1; Thu, 05 Mar 2020 03:41:40 -0500
X-MC-Unique: FyDKhKtVOMup3-dZA3TmHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD1EB100550E;
        Thu,  5 Mar 2020 08:41:39 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-204-231.brq.redhat.com [10.40.204.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BE8819C6A;
        Thu,  5 Mar 2020 08:41:35 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        joeyli <jlee@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] efi: fix a race and add a sanity check
Date:   Thu,  5 Mar 2020 09:40:38 +0100
Message-Id: <20200305084041.24053-1-vdronov@redhat.com>
In-Reply-To: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is a race and a buffer overflow while reading an efi variable
and the first patch fixes it. The second patch adds a sanity check
to efivar_store_raw(). And the third one just fixes mistypes in
comments.

Vladis Dronov (3):
  efi: fix a race and a buffer overflow while reading efivars via sysfs
  efi: add a sanity check to efivar_store_raw()
  efi: fix a mistype in comments mentioning efivar_entry_iter_begin()

 drivers/firmware/efi/efi-pstore.c |  2 +-
 drivers/firmware/efi/efivars.c    | 32 +++++++++++++++++++++++---------
 drivers/firmware/efi/vars.c       |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

