Return-Path: <linux-efi+bounces-5985-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703BD0CF33
	for <lists+linux-efi@lfdr.de>; Sat, 10 Jan 2026 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D30301E173
	for <lists+linux-efi@lfdr.de>; Sat, 10 Jan 2026 04:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00224330B13;
	Sat, 10 Jan 2026 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQ6Sjvc6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BA86347
	for <linux-efi@vger.kernel.org>; Sat, 10 Jan 2026 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768020742; cv=none; b=PT1rRAz2lu6cwXQE46LboxX5Bbxy5wOwOa+HYGPKlbeSnyhSM3IqR/lkRTm+lYQiTbkWpD0vWYMcEQm0dRc2q6mK0DW6eHuDfnDQwaR65Ap6Y72g3aiaFf9R3Y7bqFC+C71foNWmWzfkHVRwyQAmYODQO2yT/fCucuKyMxevyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768020742; c=relaxed/simple;
	bh=n+aeqojkZ3dlUD4cj9joINE6TwgEIRYu4b+YJQSzKbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXcJEO98leEMyfGNuDKel4BvLmY9afzu3oexmwJQkOFHxLEvdrjKgCj5hvDf3wa2nAQoDrg/sP9II/+ehD1YU5k3lQDhDy30dldGnbsCkH4ijLQGZtQEcJZZQYjCosfh09/PHVpx+hHY6Wd5xBCTSEs0d/xQkwNJrU3E5qR/jfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hQ6Sjvc6; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56352466d86so1420670e0c.0
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 20:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768020740; x=1768625540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlEVSJPzxTd8WIGhUtxLQx9R4YCiHxg1lgiLCe3j2u0=;
        b=qSSI+LEUmc6Ls9hFhavfI/QgB3OFQRdGz74QzK8lffBOY43U8k+CJswJVuP2/pLkjC
         iwn3MUlbJUQCLHpyvWpiSiP/OjNiICxH6+viBLvFfcSChtCpPRrFfoORwsMeA83G/Y9v
         Qd4fKc/0/g9knhO/kzpIgbNBgV/saD58xRB0pu+2+jjvGNdLDibb1af8oZymiNG4HgDo
         o1Z27YOKaJ0Z3CpcKc3fLxKmMb1hlgnaOaeCwrFDvZdkqAeosIV/01P18EqVen/sg/wQ
         KhfpftyLFMv3NB2b8rrIqaXP2qThi4kr9o5jhfgKZtrd2UP9skDRqQz9e3PUXE7F1/lr
         Iteg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZ2lgVqZyDYTUulN77RrPM5KFxiJeKozd62NU8I49ibwAOYNQg2eB/0MmoMgLSYIbu2qBbLInsLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhuMOPiHQllaPG/eTuT3DkRaVCnQeiF7s6u1uroBT5/RKTwwV
	OFcBXgdcL+8yIhdZLi1EqOo8bMzMAm6ZxJ+iGB1EzjyiKUf1+k1zDNJWC7DU6uIVDhOTStiK97n
	XgjEduqhT7Bk3WDrw60pc5v5VS7/X6OlkxACMmxtKgH/Ui19IjbpNlsgQTzlj4izRHy9NndBUx9
	ztwMAycXNe4ge7rKIkaw/wXptGTo5Vq3jkUKwInfFRRfCSCiNa4CY8txy6jMZ/HFVIqHLub9QR+
	2ocOaM34HkK
X-Gm-Gg: AY/fxX65WXZyU2dipKSnZklueYccx0j5enNhzc7EJ277+B0DgLbyJtx8cY52AiyDBWG
	UbR7LanwC82+HDQgYGVLskFZu63XXWkv8FZ0wdrO6zpegtpkGlieG6r5zptcLOpe3Chs3rNZwbg
	bTY7WsbTjw3fGY0BM2pOdZ1OOAozuIqwz7CZFG3YpIf1uR0qWI4xVNfgX5K0qHB+V5NUrmKr2ok
	WUdsLdw+BJqxNHTC//F5EPMO5EbkImC8Um8PktCn5hRbz5v/ozuk6ehhMJJyuG7ThTK5qPPhqew
	alE+XLJ0aIomi4Q5xMod49FvkBryugsFl6zl5RRkFXfhaaQFf+4BDF4Pa0VVTRiu53t2e0xMXjU
	0Vw+m+XKE0M8jvgls1mgAmSZPZ4/AJrS74XniXIRbU79kWHNw/JAWnm+aARRPoXHXIdscOfyFHn
	WTfx/UouROt+pWaNGp/JCASjGzvfcp/FPvR4XULfE=
X-Google-Smtp-Source: AGHT+IFhicDEqL+tlA41sdpjdDknnJh2tCEHI5MB2/d2ZguUS9nRtUjC5JhvEoV06WZWgPQou81QOErw8pbn
X-Received: by 2002:a05:6122:2513:b0:563:6012:53b4 with SMTP id 71dfb90a1353d-563601256ecmr2452345e0c.16.1768020740140;
        Fri, 09 Jan 2026 20:52:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56369552576sm389163e0c.6.2026.01.09.20.52.19
        for <linux-efi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 20:52:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59b6d0fd157so2351072e87.0
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 20:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768020738; x=1768625538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlEVSJPzxTd8WIGhUtxLQx9R4YCiHxg1lgiLCe3j2u0=;
        b=hQ6Sjvc6fubIKwAaww9cbNvHuzin807xXZRXKM/JjSeaT8rBJl23VtppY6wfqRF8Gf
         PBTOwXX7i5vz0j5FMa3X1vNi+8pg2znVCD9h3tYxrzwLLY2ehYjY06vldCu4GCVsmC6+
         qdp9XNQPn9O0SzeMgTOYLNqGPu2KVpDQwBHBk=
X-Forwarded-Encrypted: i=1; AJvYcCUwxRJw8Y+Y5BuVn8YskHAYpevus6v8/lsUeeioYzcp3fb+kucZWJSkQeBA5AWFJJVx3wh00pQqCSs=@vger.kernel.org
X-Received: by 2002:a05:6512:b05:b0:598:eb48:cdd7 with SMTP id 2adb3069b0e04-59b6f036b6dmr3303252e87.32.1768020738307;
        Fri, 09 Jan 2026 20:52:18 -0800 (PST)
X-Received: by 2002:a05:6512:b05:b0:598:eb48:cdd7 with SMTP id
 2adb3069b0e04-59b6f036b6dmr3303240e87.32.1768020737789; Fri, 09 Jan 2026
 20:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229215906.3688205-1-zack.rusin@broadcom.com> <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
In-Reply-To: <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 9 Jan 2026 23:52:05 -0500
X-Gm-Features: AQt7F2p8B_T8ovfD5ZSr9MTIdbY91q6Tpr9PYo2oe7dWWszTv7Z59e7mmZ6IEig
Message-ID: <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>, 
	Chia-I Wu <olvaffe@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Deepak Rawat <drawat.floss@gmail.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>, Helge Deller <deller@gmx.de>, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	spice-devel@lists.freedesktop.org, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	=?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000162d800648016896"

--000000000000162d800648016896
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:34=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi
>
> Am 29.12.25 um 22:58 schrieb Zack Rusin:
> > Almost a rite of passage for every DRM developer and most Linux users
> > is upgrading your DRM driver/updating boot flags/changing some config
> > and having DRM driver fail at probe resulting in a blank screen.
> >
> > Currently there's no way to recover from DRM driver probe failure. PCI
> > DRM driver explicitly throw out the existing sysfb to get exclusive
> > access to PCI resources so if the probe fails the system is left withou=
t
> > a functioning display driver.
> >
> > Add code to sysfb to recever system framebuffer when DRM driver's probe
> > fails. This means that a DRM driver that fails to load reloads the syst=
em
> > framebuffer driver.
> >
> > This works best with simpledrm. Without it Xorg won't recover because
> > it still tries to load the vendor specific driver which ends up usually
> > not working at all. With simpledrm the system recovers really nicely
> > ending up with a working console and not a blank screen.
> >
> > There's a caveat in that some hardware might require some special magic
> > register write to recover EFI display. I'd appreciate it a lot if
> > maintainers could introduce a temporary failure in their drivers
> > probe to validate that the sysfb recovers and they get a working consol=
e.
> > The easiest way to double check it is by adding:
> >   /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMI=
T */
> >   dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n"=
);
> >   ret =3D -EINVAL;
> >   goto out_error;
> > or such right after the devm_aperture_remove_conflicting_pci_devices .
>
> Recovering the display like that is guess work and will at best work
> with simple discrete devices where the framebuffer is always located in
> a confined graphics aperture.
>
> But the problem you're trying to solve is a real one.
>
> What we'd want to do instead is to take the initial hardware state into
> account when we do the initial mode-setting operation.
>
> The first step is to move each driver's remove_conflicting_devices call
> to the latest possible location in the probe function. We usually do it
> first, because that's easy. But on most hardware, it could happen much
> later.

Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
they request pci regions which is going to fail otherwise. Because
grabbining the pci resources is in general the very first thing that
those drivers need to do to setup anything, we
remove_conflicting_devices first or at least very early.

I also don't think it's possible or even desirable by some drivers to
reuse the initial state, good example here is vmwgfx where by default
some people will setup their vm's with e.g. 8mb ram, when the vmwgfx
loads we allow scanning out from system memory, so you can set your vm
up with 8mb of vram but still use 4k resolutions when the driver
loads, this way the suspend size of the vm is very predictable (tiny
vram plus whatever ram was setup) while still allowing a lot of
flexibility.

In general I think however this is planned it's two or three separate serie=
s:
1) infrastructure to reload the sysfb driver (what this series is)
2) making sure that drivers that do want to recover cleanly actually
clean out all the state on exit properly,
3) abstracting at least some of that cleanup in some driver independent way

z

--000000000000162d800648016896
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEII5o
RGTEyV0XeAfpw/3EFhD4hnN34Z3brBUKW0xqk8cVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExMDA0NTIxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAF1Xo42N3K3eae8tcsSKl342yCGSrVLRINZtTEq9
r63VqEAIdk89PCmgq61M9rT5wC/lhrOuNPE4WrW+Z1ZjnyFFroTD6ML1O92fBD6ngQfenx0qqqiN
3EMvaNZEewav2YLeGmd1133vuOm0UNdoCPNK0xq3AR7gtCqt7p38R15PaQgZzWhc4K8GrVEYcbJy
k1CeiWNlU+e4sXGmWAAIP2yyfTSxZc116VnRSp1vp8IKeUID6E5ozB304N1HPFHMjw+nSCeOOyCb
TWO3GNDKajKdndjDywgT4lpgz2KIjnQLKIRoYwb9pAavWOIt+M1v21zeOFwh+Iofvs4XuSoq8G8=
--000000000000162d800648016896--

