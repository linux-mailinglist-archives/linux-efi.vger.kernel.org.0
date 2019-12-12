Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56811CACC
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 11:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfLLKcH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 05:32:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728567AbfLLKcG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 05:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ziLQtEYjxvu61h+g9EC+nqhtRVmmOST0OYXIKk0q5ho=;
        b=W0H0pxldIPjefbYntaBkHb1va0/fjCk/H7EAbd/KrnCGR/iOLTEBzI20vJ+rvadALDEMxK
        5ui0m+vPIw8l+qLfIFZ6bv20CaM8Qbe9gw1zERSRWJqvYT2/feS0P3uqO6gWaUIM8oIWzz
        ZYw/juED8Z9l60InsJq7BZsv+Iexwrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-tTLposStNIWU_L_ye0hL6w-1; Thu, 12 Dec 2019 05:32:04 -0500
X-MC-Unique: tTLposStNIWU_L_ye0hL6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E201800D42;
        Thu, 12 Dec 2019 10:32:02 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA8A18779;
        Thu, 12 Dec 2019 10:32:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.5 regression fix 0/2] efi/libstub: Fix mixed-mode crash at boot
Date:   Thu, 12 Dec 2019 11:31:56 +0100
Message-Id: <20191212103158.4958-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Commit 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed th=
e UEFI RNG table")
causes drivers/efi/libstub/random.c to be used on x86 for the first time
and some of the code in that file does not deal properly with mixed-mode
setups causing a crash at boot on mixed-mode devices.

The first patch in this series fixes this and is the regression-fix from
$subject.

While looking into this I did a quick search for other cases of the same
problem in the libstub code and I found the same issue in the handling of
LILO-style file=3D kernel commandline arguments, which I guess are not
used that often because AFAICT we have no bug report for these not workin=
g
in mixed-mode. The second patch fixes this, this is a pre-existing proble=
m
and not a 5.5 regression, still we should probably also include this fix
in 5.5.

Regards,

Hans

