Return-Path: <linux-efi+bounces-2300-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9F9E63E3
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5401884953
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FC13B79F;
	Fri,  6 Dec 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gv93gwp8"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80213BAC6
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451031; cv=none; b=ownpY2z7fRfp1LqqAKfDKM0ynlWREv9z2gt95ML6l+TIMzQ3NIqjNMD+XATcoN1b4XtBQIQucjxMlkYNbxYif6riVYWsKdiNqNq7fh2kw3C5D0GCkX7BzL8qw2hj0O/lqxvCMRxbiHvYEuVhzRyHlVRhtLl6A03UJOTYzQff+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451031; c=relaxed/simple;
	bh=QuNrlkZ3+/jzG8/ayjLF8CIYn8kCJO1igwb5zXYkm74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMc7FylEdh4bOaTj9LeuWKY0EtlWkP6dIm3nlwmfC2Uvu9WQ6j16BhzoB99RNTiTba0LEtb6w/bip7xDwvG8b037kQgw110v6ZGGEM7QsM4uwqPG1M7jPGLrKUJ8Cxn//kLgjTNcl85lXbTjAjxojvnGN8HRw5nRcI0QYRdhDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gv93gwp8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ttl1CwtbP4SFjQRadlSY7toSUolnYHuGawMYMo12aNo=;
	b=Gv93gwp8txdd6I+TatxbtkxGrOdiEWXyOnJih+vx7TdP5bzD/rW9bLgj86xpMz1E41ZQYE
	dTyBQbSupzbZ1glqxL2yqNIsfgGhMULKhRklx7DeLqr2Uz/+3/bEgkKzqwg+VnQJ/6DW2B
	TD9sWmJQTceDfgHSjoTqSUHTJo3EaKw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-0kv5Of60N5GYWstlNxxtVQ-1; Thu,
 05 Dec 2024 21:10:25 -0500
X-MC-Unique: 0kv5Of60N5GYWstlNxxtVQ-1
X-Mimecast-MFC-AGG-ID: 0kv5Of60N5GYWstlNxxtVQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C0261955F43;
	Fri,  6 Dec 2024 02:10:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F23E31955F3F;
	Fri,  6 Dec 2024 02:10:18 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 0/2] Kexec: Sign Image before packing into EFI STUB
Date: Fri,  6 Dec 2024 10:09:55 +0800
Message-ID: <20241206021000.8953-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

At present, the kexec_file_load of either zboot or UKI kernel relies on
the user space to parse and extract the Image, and then pass the Image
through that syscall. During this process, the outmost signature on
zboot or UKI kernel is stripped and discarded.

On the other hand, a secure boot platform enforces the signature
verfiication on the kernel image passed through the kexec_file_load
syscall. To cater to this requirement, this patch applies signature on
the PE format 'Image' before padding.

The key used to sign is the same as module sign key, and the signing
tool is sbsign.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>   
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org


Pingfan Liu (2):
  Makefile.zboot: Sign Image before packing into EFI-STUB shell
  kexec: Introduce KEXEC_SIGN_IMAGE config option

 drivers/firmware/efi/libstub/Makefile.zboot | 13 +++++++++++++
 kernel/Kconfig.kexec                        |  9 +++++++++
 2 files changed, 22 insertions(+)

-- 
2.41.0


